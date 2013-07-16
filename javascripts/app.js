// Generated by CoffeeScript 1.4.0
(function() {
  var Choosealicense;

  Choosealicense = (function() {

    Choosealicense.prototype.flashAvailable = function() {
      if (typeof ActiveXObject !== "undefined" && ActiveXObject !== null) {
        return !!(new ActiveXObject('ShockwaveFlash.ShockwaveFlash'));
      } else {
        return !!navigator.mimeTypes["application/x-shockwave-flash"];
      }
    };

    Choosealicense.prototype.selectText = function(element) {
      var range, selection;
      if (document.body.createTextRange) {
        range = document.body.createTextRange();
        range.moveToElementText(element);
        return range.select();
      } else if (window.getSelection) {
        selection = window.getSelection();
        range = document.createRange();
        range.selectNodeContents(element);
        selection.removeAllRanges();
        return selection.addRange(range);
      }
    };

    Choosealicense.prototype.qtip_position = {
      my: "top center",
      at: "bottom center"
    };

    Choosealicense.prototype.categories = {
      required: "Required",
      permitted: "Permitted",
      forbidden: "Forbidden"
    };

    function Choosealicense() {
      this.initTooltips();
      this.initClipboard();
    }

    Choosealicense.prototype.initTooltips = function() {
      var category, label, rules, text, _ref;
      for (category in annotations) {
        rules = annotations[category];
        for (label in rules) {
          text = rules[label];
          $(".license-rules ul.license-" + category + " li." + label).attr("title", text);
        }
      }
      _ref = this.categories;
      for (category in _ref) {
        label = _ref[category];
        $(".license-" + category + " li").qtip({
          content: {
            text: false,
            title: {
              text: label
            }
          },
          position: this.qtip_position,
          style: {
            classes: "qtip-shadow qtip-" + category
          }
        });
      }
      return false;
    };

    Choosealicense.prototype.initZeroClipboard = function() {
      var clip;
      $(".js-clipboard-button").data("clipboard-prompt", $(".js-clipboard-button").text());
      clip = new ZeroClipboard($(".js-clipboard-button"), {
        moviePath: "/javascripts/ZeroClipboard.swf"
      });
      clip.on("mouseout", this.clipboardMouseout);
      clip.on("complete", this.clipboardComplete);
      return clip;
    };

    Choosealicense.prototype.initAlternativeClipboard = function() {
      var _this = this;
      return $(".js-clipboard-button").click(function(e) {
        var target;
        target = "#" + $(e.target).data("clipboard-target");
        return _this.selectText($(target)[0]);
      });
    };

    Choosealicense.prototype.initClipboard = function() {
      if ((typeof ZeroClipboard !== "undefined" && ZeroClipboard !== null) && this.flashAvailable()) {
        return this.initZeroClipboard();
      } else {
        return this.initAlternativeClipboard();
      }
    };

    Choosealicense.prototype.clipboardMouseout = function(client, args) {
      return this.innerText = $(this).data("clipboard-prompt");
    };

    Choosealicense.prototype.clipboardComplete = function(client, args) {
      return this.innerText = "Copied!";
    };

    return Choosealicense;

  })();

  $(function() {
    return new Choosealicense();
  });

}).call(this);
