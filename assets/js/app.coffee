---
---

class Choosealicense
  # Selects the content of a given element
  selectText: (element) ->
    if document.body.createTextRange
      range = document.body.createTextRange()
      range.moveToElementText(element)
      range.select()
    else if window.getSelection
      selection = window.getSelection()
      range = document.createRange()

      range.selectNodeContents(element)
      selection.removeAllRanges()
      selection.addRange(range)

  # Qtip position attributes for tooltips
  qtip_position:
    my: "top center"
    at: "bottom center"

  # Annotation rule types as defined in `_config.yml`
  ruletypes:
    permissions: "Permission"
    conditions: "Condition"
    limitations: "Limitation"

  # fire on document.ready
  constructor: ->
    @initTooltips()
    @initClipboard()

  # Init tooltip action
  initTooltips: ->

    # Dynamically add annotations as title attribute to rule list items
    for ruletype, rules of window.annotations
      for rule in rules
        $(".license-#{ruletype} .#{rule["tag"]}").attr "title", rule["description"]

    # Init tooltips on all rule list items
    for ruletype, label of @ruletypes
      $(".license-#{ruletype} li, .license-#{ruletype} .license-sprite").qtip
        content:
          text: false
          title:
            text: label
        position: @qtip_position
        style:
          classes: "qtip-shadow qtip-#{ruletype}"

    false

  # Initializes Clipboard.js
  initClipboard: ->
    # Backup the clipboard button's original text.
    $(".js-clipboard-button").data "clipboard-prompt", $(".js-clipboard-button").text()

    # Hook up copy to clipboard buttons
    clip = new Clipboard ".js-clipboard-button"
    clip.on "mouseout", @clipboardMouseout
    clip.on "complete", @clipboardComplete

  # Callback to restore the clipboard button's original text
  clipboardMouseout: (client, args) ->
    @textContent = $(this).data("clipboard-prompt")

  # Post-copy user feedback callback
  clipboardComplete: (client, args) ->
    @textContent = "Copied!"

$ ->
  new Choosealicense()
