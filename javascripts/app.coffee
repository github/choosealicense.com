class Choosealicense

  # Checks if Flash is available in the client.
  flashAvailable: ->
    if ActiveXObject?
      !!(new ActiveXObject('ShockwaveFlash.ShockwaveFlash'))
    else
      !!navigator.mimeTypes["application/x-shockwave-flash"]

  # Selects the content of a given element
  selectText: (element) ->
    if document.body.createTextRange
      range = document.body.createTextRange();
      range.moveToElementText(element);
      range.select();
    else if window.getSelection
      selection = window.getSelection()
      range = document.createRange()

      range.selectNodeContents(element)
      selection.removeAllRanges();
      selection.addRange(range);

  # Qtip position attributes for tooltips
  qtip_position:
    my: "top center"
    at: "bottom center"

  # Annotation categories as defined in `_config.yml`
  categories:
    required: "요구사항"
    permitted: "허가사항"
    forbidden: "금지사항"

  # fire on document.ready
  constructor: ->
    @initTooltips()
    @initClipboard()

  # Init tooltip action
  initTooltips: ->

    # Dynamically add annotations as title attribute to rule list items
    for category, rules of annotations
      for label, text of rules
        $(".license-rules ul.license-#{category} li.#{label}").attr "title", text

    # Init tooltips on all rule list items
    for category, label of @categories
      $(".license-#{category} li").qtip
        content:
          text: false
          title:
            text: label
        position: @qtip_position
        style:
          classes: "qtip-shadow qtip-#{category}"

    false

  # Initializes ZeroClipboard
  initZeroClipboard: ->
      # Backup the clipboard button's original text.
      $(".js-clipboard-button").data "clipboard-prompt", $(".js-clipboard-button").text()

      # Hook up copy to clipboard buttons
      clip = new ZeroClipboard $(".js-clipboard-button"),
        moviePath: "{{ site.base-url }}/javascripts/ZeroClipboard.swf"
      clip.on "mouseout", @clipboardMouseout
      clip.on "complete", @clipboardComplete
      clip

  # Initializes an alternative way to copy the license for non-flash compatible
  # browsers
  initAlternativeClipboard: ->
    $(".js-clipboard-button").click (e) =>
      target = "#" + $(e.target).data("clipboard-target")
      @selectText $(target)[0]

  # if Zero Clipboard is present, bind to button and init
  initClipboard: ->
    if ZeroClipboard? && @flashAvailable()
      @initZeroClipboard()
    else
      @initAlternativeClipboard()

  # Callback to restore the clipboard button's original text
  clipboardMouseout: (client, args) ->
    @innerText = $(this).data("clipboard-prompt")

  # Post-copy user feedback callback
  clipboardComplete: (client, args) ->
    @innerText = "Copied!"

$ ->
  new Choosealicense()
