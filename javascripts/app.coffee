class Choosealicense

  # Qtip position attributes for tooltips
  qtip_position:
    my: "top center"
    at: "bottom center"

  # Annotation categories as defined in `_config.yml`
  categories:
    required: "Required"
    permitted: "Permitted"
    forbidden: "Forbidden"

  # fire on document.ready
  constructor: ->
    @initTooltips()
    @initClipboard() if ZeroClipboard?

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

  # if Zero Clipboard is present, bind to button and init
  initClipboard: ->

    # Backup the clipboard button's original text.
    $(".js-clipboard-button").data "clipboard-prompt", $(".js-clipboard-button").text()
  
    # Hook up copy to clipboard buttons
    clip = new ZeroClipboard $(".js-clipboard-button"),
      moviePath: "/javascripts/ZeroClipboard.swf"
    clip.on "mouseout", @clipboardMouseout
    clip.on "complete", @clipboardComplete
    clip
  
  # Callback to restore the clipboard button's original text
  clipboardMouseout: (client, args) ->
    @innerText = $(this).data("clipboard-prompt")

  # Post-copy user feedback callback
  clipboardComplete: (client, args) ->
    @innerText = "Copied!"

$ ->
  new Choosealicense()