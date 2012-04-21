Type.registerNamespace('GT.Ajax.Scripts');

GT.Ajax.Scripts.ControlValidator = function() {
  GT.Ajax.Scripts.ControlValidator.initializeBase(this);
};

GT.Ajax.Scripts.ControlValidator.prototype = {
  ValidateEmail: function(control, args) {
    args.IsValid = String.isNullOrEmpty(args.Value) == true
            || (args.Value && args.Value.toUpperCase().match(/^[A-Z0-9._%-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/));
  }
};

GT.Ajax.Scripts.ControlValidator.registerClass('GT.Ajax.Scripts.ControlValidator');

var ControlValidator = new GT.Ajax.Scripts.ControlValidator();