
Type.registerNamespace("GT.Ajax.Scripts");

GT.Ajax.Scripts.DomManager = function() {
}

GT.Ajax.Scripts.DomManager.prototype =
{
  findFirstSelectedValue: function(select) {
    if (select) {
      var elems = select.getElementsByTagName("input");
      if (elems) {
        for (var i = 0; i < elems.length; i++) {
          if (elems[i] && elems[i].checked) {
            return elems[i].value;
          }
        }
      }
    }
    return null;
  }

    , isChecked: function(checkBox) {
      return checkBox && checkBox.checked;
    }

    , getSelectedValue: function(select) {
      if (select && select.selectedIndex >= 0) {
        return select.options[select.selectedIndex].value;
      }
      else {
        null;
      }
    }

    , disable: function(element) {
      if (element != null) {
        element.disabled = true;
      }
    }

    , enable: function(element) {
      if (element != null) {
        element.disabled = false;
      }
    }

    , removeElement: function(element) {
      if (element != null && element.parentNode != null) {
        element.parentNode.removeChild(element);
      }
    }

    , setCssClass: function(element, cssClassName) {
      if (element != null) {
        element.className = cssClassName;
      }
    }

    , getText: function(element) {
      if (Sys.Browser.agent === Sys.Browser.InternetExplorer) {
        return element.innerText;
      }
      else {
        return element.textContent;
      }
    }

    , setText: function(element, text) {
      if (element) {
        if (Sys.Browser.agent === Sys.Browser.InternetExplorer) {
          element.innerText = text;
        }
        else {
          element.textContent = text;
        }
      }
    }

    , setValue: function(element, value) {
      if (element != null) {
        element.value = value;
        $common.tryFireEvent(element, "change");
      }
    }

    , getValue: function(element) {
      if (element != null) {
        return element.value;
      }
      else {
        return null;
      }
    }

    , isVisible: function(element) {
      if (null != element && null != element.style) {
        return element.style.visibility != "hidden"
                && element.style.display != "none";
      }
    }

    , show: function(element) {
      if (element != null && element.style != null) {
        element.style.visibility = "visible";
        element.style.display = "";
      }
    }

    , hide: function(element, entirely) {
      if (element != null && element.style != null) {
        element.style.visibility = "hidden";
        if (entirely == true) {
          element.style.display = "none";
        }
      }
    }

    , setHref: function(element, href) {
      if (element != null) {
        element.href = href;
      }
    }

    , getAttributeValue: function(element, attributeName) {
      if (element != null && attributeName != null) {
        var attr = element.attributes[attributeName];
        if (attr != null) {
          return attr.value;
        }
      }
      return null;
    }

    , setAttributeValue: function(element, attributeName, attributeValue) {
      if (element != null && attributeName != null) {
        var attr = element.attributes[attributeName];
        if (attr != null) {
          attr.value = attributeValue;
        }
      }
    }

    , dispose: function() {
    }
}
GT.Ajax.Scripts.DomManager.registerClass('GT.Ajax.Scripts.DomManager', null, Sys.IDisposable);

var DomManager = new GT.Ajax.Scripts.DomManager();

// Notify ScriptManager that this is the end of the script.
if (typeof (Sys) !== 'undefined') Sys.Application.notifyScriptLoaded();
