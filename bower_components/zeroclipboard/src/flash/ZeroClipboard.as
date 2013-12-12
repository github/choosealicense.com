package {

  import flash.display.Stage;
  import flash.display.Sprite;
  import flash.display.LoaderInfo;
  import flash.events.*;
  import flash.external.ExternalInterface;
  import flash.utils.*;
  import flash.system.Capabilities;

  // ZeroClipboard
  //
  // The ZeroClipboard class creates a simple sprite button that will put
  // text in your clipboard when clicked
  //
  // returns nothing
  public class ZeroClipboard extends Sprite {

    // "CONSTANTS" 
    // Function through which JavaScript events are dispatched normally
    private static var normalDispatcher:String = "ZeroClipboard.dispatch";

    // Function through which JavaScript events are dispatched if using an AMD loader
    private static var amdWrappedDispatcher:String =
      "(function (event, args, amdModuleId) {\n" +
      "  require([amdModuleId], function (ZeroClipboard) {\n" +
      "    ZeroClipboard.dispatch(event, args);\n" +
      "  });\n" +
      "})";

    // Function through which JavaScript events are dispatched if using a CommonJS module loader
    private static var cjsWrappedDispatcher:String =
      "(function (event, args, cjsModuleId) {\n" +
      "  var ZeroClipboard = require(cjsModuleId);\n" +
      "  ZeroClipboard.dispatch(event, args);\n" +
      "})";


    // The button sprite
    private var button:Sprite;

    // The text in the clipboard
    private var clipText:String = "";

    // AMD module ID or path to access the ZeroClipboard object
    private var amdModuleId:String = null;

    // CommonJS module ID or path to access the ZeroClipboard object
    private var cjsModuleId:String = null;

    // constructor, setup event listeners and external interfaces
    public function ZeroClipboard() {

      // Align the stage to top left
      stage.align = "TL";
      stage.scaleMode = "noScale";

      // Get the flashvars
      var flashvars:Object = LoaderInfo( this.root.loaderInfo ).parameters;

      // Allow the SWF object to communicate with a page on a different origin than its own (e.g. SWF served from CDN)
      if (flashvars.trustedOrigins && typeof flashvars.trustedOrigins === "string") {
        var origins:Array = flashvars.trustedOrigins.split("\\").join("\\\\").split(",");
        flash.system.Security.allowDomain.apply(null, origins);
      }
      
      // Enable complete AMD support (e.g. RequireJS)
      if (flashvars.amdModuleId && typeof flashvars.amdModuleId === "string") {
        amdModuleId = flashvars.amdModuleId.split("\\").join("\\\\");
      }

      // Enable complete CommonJS support (e.g. Browserify)
      if (flashvars.cjsModuleId && typeof flashvars.cjsModuleId === "string") {
        cjsModuleId = flashvars.cjsModuleId.split("\\").join("\\\\");
      }

      // invisible button covers entire stage
      button = new Sprite();
      button.buttonMode = true;
      button.useHandCursor = false;
      button.graphics.beginFill(0xCCFF00);
      button.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
      button.alpha = 0.0;
      addChild(button);

      // Adding the event listeners
      button.addEventListener(MouseEvent.CLICK, mouseClick);
      button.addEventListener(MouseEvent.MOUSE_OVER, mouseOver);
      button.addEventListener(MouseEvent.MOUSE_OUT, mouseOut);
      button.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
      button.addEventListener(MouseEvent.MOUSE_UP, mouseUp);

      // external functions
      ExternalInterface.addCallback("setHandCursor", setHandCursor);
      ExternalInterface.addCallback("setText", setText);
      ExternalInterface.addCallback("setSize", setSize);

      // signal to the browser that we are ready
      dispatch("load", ZeroClipboard.metaData());
    }

    // mouseClick
    //
    // The mouseClick private function handles clearing the clipboard, and
    // setting new clip text. It gets this from the clipText private variable.
    // Once the text has been placed in the clipboard, It then signals to the
    // Javascript that it is done.
    //
    // returns nothing
    private function mouseClick(event:MouseEvent): void {

      // Linux currently doesn't use the correct clipboard buffer with the new
      // Flash 10 API, so we need to use this until we can figure out an alternative
      flash.system.System.setClipboard(clipText);

      // signal to the page it is done
      dispatch("complete", ZeroClipboard.metaData(event, {
        text: clipText.split("\\").join("\\\\")
      }));

      // reset the text
      clipText = "";
    }

    // mouseOver
    //
    // The mouseOver function signals to the page that the button is being hovered.
    //
    // returns nothing
    private function mouseOver(event:MouseEvent): void {
      dispatch("mouseOver", ZeroClipboard.metaData(event));
    }

    // mouseOut
    //
    // The mouseOut function signals to the page that the button is not being hovered.
    //
    // returns nothing
    private function mouseOut(event:MouseEvent): void {
      dispatch("mouseOut", ZeroClipboard.metaData(event));
    }

    // mouseDown
    //
    // The mouseDown function signals to the page that the button has a mouse button down.
    //
    // returns nothing
    private function mouseDown(event:MouseEvent): void {
      dispatch("mouseDown", ZeroClipboard.metaData(event));

      // if the clipText hasn't been set
      if (!clipText) {
        // request data from the page
        dispatch("dataRequested", ZeroClipboard.metaData(event));
      }
    }

    // mouseUp
    //
    // The mouseUp function signals to the page that the mouse button has been lifted
    //
    // returns nothing
    private function mouseUp(event:MouseEvent): void {
      dispatch("mouseUp", ZeroClipboard.metaData(event));
    }

    // setText
    //
    // setText gets the clipboard text to be copied from the javascript.
    //
    // returns nothing
    public function setText(newText:String): void {
      // set the maximum number of files allowed
      clipText = newText;
    }

    // setHandCursor
    //
    // setHandCursor will make the button cursor be a hand on hover.
    //
    // returns nothing
    public function setHandCursor(enabled:Boolean): void {
      button.useHandCursor = enabled;
    }

    // setSize
    //
    // Sets the size of the button to equal the size of the hovered object.
    //
    // returns nothing
    public function setSize(width:Number, height:Number): void {
      button.width = width;
      button.height = height;
    }
    
    // dispatch
    //
    // Function through which JavaScript events are dispatched
    //
    // returns nothing
    private function dispatch(eventName:String, eventArgs:Object): void {
      if (amdModuleId) {
        ExternalInterface.call(ZeroClipboard.amdWrappedDispatcher, eventName, eventArgs, amdModuleId);
      }
      else if (cjsModuleId) {
        ExternalInterface.call(ZeroClipboard.cjsWrappedDispatcher, eventName, eventArgs, cjsModuleId);
      }
      else {
        ExternalInterface.call(ZeroClipboard.normalDispatcher, eventName, eventArgs);
      }
    }

    // metaData
    //
    // The metaData function will take a mouseEvent, and an extra object to
    // create a meta object of more info. This will let the page know if
    // certain modifier keys are down
    //
    // returns an Object of extra event data
    private static function metaData(event:MouseEvent = void, extra:Object = void):Object {

      // create the default options, contains flash version
      var normalOptions:Object = {
        flashVersion: Capabilities.version
      };

      // if an event is passed in, return what modifier keys are pressed
      if (event) {
        normalOptions.altKey = event.altKey;
        normalOptions.ctrlKey = event.ctrlKey;
        normalOptions.shiftKey = event.shiftKey;
      }

      // for everything in the extra object, add it to the normal options
      for (var i:String in extra) {
        normalOptions[i] = extra[i];
      }

      return normalOptions;
    }
  }
}
