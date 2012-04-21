Type.registerNamespace('GT.Ajax.Scripts');

GT.Ajax.Scripts.OfferFilterPopup = function(popupId, popupTitle) {
  this._popupId = popupId;
  this._searchIn = GT.Ajax.Scripts.SearchIn.Selling;
  if (this._popupId) {
    var dialogOptions = { autoOpen: false,
      //height: 150,
      width: 350,
      modal: false,
      draggable: true,
      resizable: false,
      title: popupTitle,
      closeOnEscape: true
    };
  }
  $(String.format("#{0}", popupId)).dialog(dialogOptions);
  GT.Ajax.Scripts.OfferFilterPopup.initializeBase(this);
};

GT.Ajax.Scripts.OfferFilterPopup.prototype = {
  open: function(searchIn) {
    this._searchIn = searchIn;
    $(String.format("#{0}", this._popupId)).dialog('open');
  },

  close: function() {
    $(String.format("#{0}", this._popupId)).dialog("close");
  },

  get_inSearch: function() {
    return this._searchIn;
  }
};

GT.Ajax.Scripts.OfferFilterPopup.registerClass('GT.Ajax.Scripts.OfferFilterPopup');


/*Authentication Popup*/
GT.Ajax.Scripts.AuthenticationPopup = function(popupId, popupTitle, onSignInSuccess, onSignInFailure, onSignUpSuccess, onSignUpFailure) {
  this._popupId = popupId;
  this._redirectUrl = null;
  this._onSignInSuccessInternal = onSignInSuccess;
  this._onSignInFailureInternal = onSignInFailure;
  this._onSignUpSuccessInternal = onSignUpSuccess;
  this._onSignUpFailureInternal = onSignUpFailure;
  this._onSuccess = null;
  this._onFailure = null;
  if (this._popupId) {
    var dialogOptions = { autoOpen: false,
      //height: 150,
      width: 380,
      modal: false,
      draggable: true,
      resizable: false,
      title: popupTitle,
      closeOnEscape: true
    };
    $(String.format("#{0}", popupId)).dialog(dialogOptions);
  }
  GT.Ajax.Scripts.AuthenticationPopup.initializeBase(this);
};

GT.Ajax.Scripts.AuthenticationPopup.prototype = {
  raise_onSuccess: function() {
    if (this._onSuccess !== undefined) {
      this._onSuccess.call();
    }
  },

  raise_onFailure: function() {
    if (this._onFailure !== undefined) {
      this._onFailure.call();
    }
  },

  open: function(onSuccess, onFailure, redirectUrl) {
    this._redirectUrl = redirectUrl;
    this._onSuccess = onSuccess;
    this._onFailure = onFailure;
    if (Sys.Services.AuthenticationService.get_isLoggedIn() == false) {
      $(String.format("#{0}", this._popupId)).dialog('open');
    }
    else {
      this.raise_onSuccess();
    }
  },

  close: function() {
    $(String.format("#{0}", this._popupId)).dialog("close");
  },

  signIn: function(userName, password, remember) {
    Sys.Services.AuthenticationService.login(userName
    , password
    , remember ? remember : false
    , null
    , this._redirectUrl
    , this._onSignInSuccessInternal
    , this._onSignInFailureInternal
    , null);
  },

  signUp: function(userName, password, email, question, answer, key) {
    GT.Web.Site.WebServices.Ajax.UsersService.SignUp(userName, password, email, question, answer, key
      , this._onSignUpSuccessInternal
      , this._onSignUpFailureInternal
    );
  }
};

GT.Ajax.Scripts.AuthenticationPopup.registerClass('GT.Ajax.Scripts.AuthenticationPopup');


GT.Ajax.Scripts.PopupWindow = function() {
  GT.Ajax.Scripts.PopupWindow.initializeBase(this);
};

GT.Ajax.Scripts.PopupWindow.prototype = {
  Url: '',
  WindowHeader: '',
  Width: 0,
  Height: 0,
  Top: 0,
  Left: 0,
  MenuBar: GT.Ajax.Scripts.YesNo.No,
  Resizable: GT.Ajax.Scripts.YesNo.Yes,
  ScrollBars: GT.Ajax.Scripts.YesNo.Yes,
  Options: null,
  DefaultOptions: {},
  get_Url: function() {
    var sTemplate = this.Url;
    var options = {};
    $.extend(options, this.DefaultOptions, this.Options);
    for (var prop in options) {
      if (sTemplate.indexOf('{' + prop + '}') != -1) {
        sTemplate = sTemplate.replace('{' + prop + '}', options[prop]);
      }
    }
    return sTemplate;
  }
};

GT.Ajax.Scripts.PopupWindow.registerClass('GT.Ajax.Scripts.PopupWindow');

GT.Ajax.Scripts.PopupManager = function() {
  GT.Ajax.Scripts.PopupManager.initializeBase(this);
};

GT.Ajax.Scripts.PopupManager.prototype = {
  WINDOW_HEADER: 35,
  Open: function(p_WindowObject, p_options) {
    if (Object.getTypeName(p_WindowObject) == 'GT.Ajax.Scripts.PopupWindow') {
      p_WindowObject.Options = p_options;
      this.PrepareResize(p_WindowObject);
      var sOptions = String.format("width={0},height={1},top={2},left={3},menubar={4},resizable={5},scrollbars={6}",
                    p_WindowObject.Width, p_WindowObject.Height, p_WindowObject.Top, p_WindowObject.Left,
                    p_WindowObject.MenuBar, p_WindowObject.Resizable, p_WindowObject.ScrollBars);
      try {
        var wnd = window.open(p_WindowObject.get_Url(), p_WindowObject.WindowHeader, sOptions);
        wnd.focus();
        return wnd;
      }
      catch (e) {
        return true;
      }
    }
    else {
      var err = Error.argumentType('p_WindowObject', Object.getType(p_WindowObject), GT.Ajax.Scripts.PopupWindow, 'Cannot initialize popup window');
      throw err;
    }
  },

  PrepareResize: function(p_WindowObject) {
    if ((p_WindowObject.Top + p_WindowObject.Height) >= window.screen.availHeight)
      p_WindowObject.Top = 0;
    if (p_WindowObject.Height > window.screen.availHeight) {
      p_WindowObject.Height = window.screen.availHeight;
      p_WindowObject.Height -= this.WINDOW_HEADER;
    }
    if ((p_WindowObject.Left + p_WindowObject.Width) > window.screen.availWidth)
      p_WindowObject.Left = 0;
    if (p_WindowObject.Width > window.screen.availWidth)
      p_WindowObject.Width = window.screen.availWidth;
  },

  close: function(reloadOpener, url) {
    if (reloadOpener && window.opener && window.opener.location) {
      if (url) {
        window.opener.location.href = url;
      }
      else {
        window.opener.location.href = window.opener.location.href;
      }
      window.close();
    }
  },
  raise_onAddSellingClick: function(event) {
    authenticationPopup.open(
        function() { //success
          PopupManager.Open(EditSelling, { Id: 0, RedirectUrl: "%2FOffers%2FSellingManager.aspx" });
          //window.redirect("/Office/Selling");
        }
        , function() { //failure
          //todo: handle error
        }
      );
    window.cancelEvent(event);
  },

  raise_onAddBuyingClick: function(event) {
    authenticationPopup.open(
        function() { //success
          PopupManager.Open(EditBuying, { Id: 0, RedirectUrl: "%2FOffers%2FBuyingManager.aspx" });
          //window.redirect("/Office/Buying");
        }
        , function() { //failure
          //todo: handle error
        }
      );
    window.cancelEvent(event);
  },

  raise_onBuyingFilterClick: function(event) {
    offerFilterPopup.open(GT.Ajax.Scripts.SearchIn.Buying);
    window.cancelEvent(event);
  },

  raise_onSellingFilterClick: function(event) {
    offerFilterPopup.open(GT.Ajax.Scripts.SearchIn.Selling);
    window.cancelEvent(event);
  }
};

GT.Ajax.Scripts.PopupManager.registerClass('GT.Ajax.Scripts.PopupManager');


//Global object Popup Manager
var PopupManager = new GT.Ajax.Scripts.PopupManager();

//Popup window objects


var ViewGameInfo = new GT.Ajax.Scripts.PopupWindow();
ViewGameInfo.Url = '/DetailsInfo/GameInfo.aspx?GameID={GameID}&om=Popup';
ViewGameInfo.Width = 795;
ViewGameInfo.Height = 900;
ViewGameInfo.Top = 50;
ViewGameInfo.Left = 50;
ViewGameInfo.DefaultOptions = {
  GameID: -1
};

var ViewGameServerInfo = new GT.Ajax.Scripts.PopupWindow();
ViewGameServerInfo.Url = '/DetailsInfo/GameServerInfo.aspx?GameServerID={GameServerID}&om=Popup';
ViewGameServerInfo.Width = 795;
ViewGameServerInfo.Height = 900;
ViewGameServerInfo.Top = 50;
ViewGameServerInfo.Left = 50;
ViewGameServerInfo.DefaultOptions = {
  GameServerID: -1
};

var ViewUserInfo = new GT.Ajax.Scripts.PopupWindow();
ViewUserInfo.Url = '/DetailsInfo/UserInfo.aspx?UserID={UserID}&om=Popup';
ViewUserInfo.Width = 795;
ViewUserInfo.Height = 900;
ViewUserInfo.Top = 50;
ViewUserInfo.Left = 50;
ViewUserInfo.DefaultOptions = {
  UserID: -1
};

var ViewOfferInfo = new GT.Ajax.Scripts.PopupWindow();
ViewOfferInfo.Url = '/DetailsInfo/OfferInfo.aspx?id={OfferID}&om=Popup';
ViewOfferInfo.Width = 795;
ViewOfferInfo.Height = 900;
ViewOfferInfo.Top = 50;
ViewOfferInfo.Left = 50;
ViewOfferInfo.DefaultOptions = {
  OfferID: -1
};

var ViewBuyingOfferInfo = new GT.Ajax.Scripts.PopupWindow();
ViewBuyingOfferInfo.Url = '/DetailsInfo/BuyingOfferInfo.aspx?id={BuyingOfferID}&om=Popup';
ViewBuyingOfferInfo.Width = 795;
ViewBuyingOfferInfo.Height = 900;
ViewBuyingOfferInfo.Top = 50;
ViewBuyingOfferInfo.Left = 50;
ViewBuyingOfferInfo.DefaultOptions = {
  BuyingOfferID: -1
};

var ViewNewsInfo = new GT.Ajax.Scripts.PopupWindow();
ViewNewsInfo.Url = '/DetailsInfo/NewsInfo.aspx?NewsId={NewsID}&om=Popup';
ViewNewsInfo.Width = 795;
ViewNewsInfo.Height = 900;
ViewNewsInfo.Top = 50;
ViewNewsInfo.Left = 50;
ViewNewsInfo.DefaultOptions = {
  NewsID: -1
};

var EditSelling = new GT.Ajax.Scripts.PopupWindow();
EditSelling.Url = '/Office/Buying/Edit/{Id}';
EditSelling.Width = 600;
EditSelling.Height = 750;
EditSelling.Top = 50;
EditSelling.Left = 50;
EditSelling.DefaultOptions = {
  Id: 0,
  RedirectUrl: ""
};

var EditBuying = new GT.Ajax.Scripts.PopupWindow();
EditBuying.Url = '/Office/Buying/Edit/{Id}/url={RedirectUrl}&om=Popup';
EditBuying.Width = 600;
EditBuying.Height = 650;
EditBuying.Top = 50;
EditBuying.Left = 50;
EditBuying.DefaultOptions = {
  Id: 0,
  RedirectUrl: ""
};

var AddMessage = new GT.Ajax.Scripts.PopupWindow();
AddMessage.Url = '/MessageSystem/AddMessage.aspx?rid={RecipientId}&om=Popup';
AddMessage.Width = 550;
AddMessage.Height = 500;
AddMessage.Top = 50;
AddMessage.Left = 50;
AddMessage.DefaultOptions = {
  RecipientId: ''
};

var EditProfile = new GT.Ajax.Scripts.PopupWindow();
EditProfile.Url = '/PersonalAccount/Profile.aspx?om=Popup';
EditProfile.Width = 590;
EditProfile.Height = 700;
EditProfile.Top = 50;
EditProfile.Left = 50;
EditProfile.DefaultOptions = {
};

var AddFeedback = new GT.Ajax.Scripts.PopupWindow();
AddFeedback.Url = '/UserRating/AddFeedback.aspx?id={Id}&shid={SellingHistoryId}&om=Popup';
AddFeedback.Width = 550;
AddFeedback.Height = 500;
AddFeedback.Top = 50;
AddFeedback.Left = 50;
AddFeedback.DefaultOptions = {
  Id: 0,
  SellingHistoryId: 0
};