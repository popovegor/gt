Type.registerNamespace('GT.Ajax.Scripts');
GT.Ajax.Scripts.YesNo = function() {
};

GT.Ajax.Scripts.YesNo.prototype = {
  Yes: 1,
  No: 0
};

GT.Ajax.Scripts.YesNo.registerEnum("GT.Ajax.Scripts.YesNo", false);

GT.Ajax.Scripts.FormActions = function() {
};

GT.Ajax.Scripts.FormActions.prototype = {
  Close: 0,
  CloseAndRedirect: 1,
  AddNewClearForm: 2,
  AddNewLeaveData: 3,
  PickEntity: 4
};
GT.Ajax.Scripts.FormActions.registerEnum("GT.Ajax.Scripts.FormActions", false);

GT.Ajax.Scripts.SearchIn = function() {
};

GT.Ajax.Scripts.SearchIn.prototype = {
  Buying: 1,
  Selling: 0
};

GT.Ajax.Scripts.SearchIn.registerEnum("GT.Ajax.Scripts.SearchIn", false);

String.isNullOrEmpty = function(str) {
  return str == null || str == '';
};

window.cancelEvent = function(p_event) {
  if (p_event != null) {
    var domEventVar = new Sys.UI.DomEvent(p_event);
    domEventVar.preventDefault();
    domEventVar.stopPropagation();
  }
};

window.AuthenticateIfNeeded = function() {
  if (false == Sys.Services.AuthenticationService.get_isLoggedIn() && window && window.location) {
    var url = String.format("/SignIn/{0}{1}"
            , window.location.pathname
            , window.location.search);
    window.location.assign(url);
    window.location.href = url;
  }
};

window.redirect = function(url) {
  window.location = url;
};

//source: http://www.onlineaspect.com/2007/06/08/auto-detect-a-time-zone-with-javascript/
//in order to use this method the reference "GT.Web.Site.WebServices.UsersService" is required
window.setTimeZone = function() {
  var myDate = new Date();
  //document.write(myDate.getTimezoneOffset());
  var rightNow = new Date();
  var jan1 = new Date(rightNow.getFullYear(), 0, 1, 0, 0, 0, 0);
  var temp = jan1.toGMTString();
  var jan2 = new Date(temp.substring(0, temp.lastIndexOf(" ") - 1));
  var std_time_offset = (jan1 - jan2) / (1000 * 60);
  var june1 = new Date(rightNow.getFullYear(), 6, 1, 0, 0, 0, 0);
  temp = june1.toGMTString();
  var june2 = new Date(temp.substring(0, temp.lastIndexOf(" ") - 1));
  var daylight_time_offset = (june1 - june2) / (1000 * 60);
  var dst;
  if (std_time_offset == daylight_time_offset) {
    dst = false; // daylight savings time is NOT observed
  } else {
    dst = true; // daylight savings time is observed
  }
  GT.Web.Site.WebServices.Ajax.UsersService.SetTimeZone(std_time_offset, dst
    , function(result) {
    } //success
    , function(error) {
    } //failure
  )
  };

  window.goBack = function(event) {
  if (typeof (window.back) == "function") {
    window.back();
  }
  if (typeof (history.back) == "function") {
    history.back();
  }
  window.cancelEvent(event);
  };



