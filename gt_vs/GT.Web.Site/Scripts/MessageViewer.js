function msg_get(id) {
  var msg = $(String.format("tr.row[entity={0}] div.new", id));
  return msg;
};

function msg_reply(event, id) {
  var txt = $(String.format("tr.row[entity={0}] div.new textarea", id));
  txt.textLimiter({ maxLength: 250});
  var msg = msg_get(id);
  msg.show();
  window.cancelEvent(event);
};

function msg_send(event, id, recipient, successText) {
  Page_ClientValidate(id);
  if (Page_IsValid) {
    var btn = event.target;
    $(btn).attr('disabled', 'disabled');
    var msg = msg_get(id);
    var txt = $(String.format("tr.row[entity={0}] div.new textarea", id));
    var body = txt.val();
    GT.Web.Site.WebServices.Ajax.MessageSystemService.AddMessage(recipient, body,
        function(result) { //success
          if (result.MessageId > 0) {
            alert(successText);
            msg.hide();
            $(btn).attr('disabled', '');
            txt.val("");
          } //success
        });
  }
  window.cancelEvent(event);
};

function msg_cancel(event, id) {
  var msg = msg_get(id);
  msg.hide();
  window.cancelEvent(event);
  return false;
};