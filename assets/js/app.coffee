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
    @initLicenseSuggestion()
    @initAnnotationHighlighter()

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
  
  # Initializes the repository suggestion feature
  initLicenseSuggestion: ->
    inputEl = $("#repository-url")
    licenseId = inputEl.attr("data-license-id")
    statusIndicator = $(".status-indicator")
    new LicenseSuggestion(inputEl, licenseId, statusIndicator)
  
  initAnnotationHighlighter: ->
    rulesElements = $(".license-rules li")
    licenseTextElement = $("#license-text")
    new AnnotationHighlighter(rulesElements, licenseTextElement)

class LicenseSuggestion
  constructor: (@inputEl, @licenseId, @statusIndicator) ->
    @setupTooltips()
    @bindEventHandlers()
  
  # Initializes tooltips on the input element
  setupTooltips: =>
    @inputEl.qtip
      content:
        text: false
        title:
          text: "message"
      show: false
      hide: false
      position:
        my: "top center"
        at: "bottom center"
      style:
        classes: "qtip-shadow"
  
  # Main event handlers for user input
  bindEventHandlers: =>    
    @inputEl.on "input", (event) =>
      @setStatus ""
    .on "keyup", (event) =>            
      if event.keyCode == 13 and event.target.value
        # Validate the user input first
        try
          repositoryFullName = @parseUserInput event.target.value
        catch
          @setStatus "Error", "Invalid URL."
          return
        
        @setStatus "Fetching"        
        @fetchInfoFromGithubAPI repositoryFullName, (err, repositoryInfo=null) =>
          if (err)
            @setStatus "Error", err.message
            return
          if repositoryInfo.license # The repository already has a license
            license = repositoryInfo.license
            @setStatus "Error", @repositoryLicense repositoryFullName, license
          else # The repository is not licensed
            licenseUrl = encodeURIComponent "https://github.com/#{repositoryFullName}/community/license/new?template=#{@licenseId}"
            # Provide the chance to the user log-in, since the URL to suggest a license is restricted
            window.location.href = "https://github.com/login?return_to=#{licenseUrl}"
            @setStatus ""
            @inputEl.val("")

  # Try to extract the repository full name from the user input
  parseUserInput: (userInput) ->
    repository = /https?:\/\/github\.com\/(.*?)\/(.+)(\.git)?$/.exec userInput
    [_, username, project] = repository
    project = project
      .split /\/|\.git/
      .filter (str) -> str
      .slice 0, 1
      .join ""
    return username + '/' + project
  
  # Displays an indicator and tooltips to the user about the current status
  setStatus: (status="", message="") =>
    statusClass = status.toLowerCase()
    displayQtip = (status, message) =>
      @inputEl.qtip("api")
        .set("content.text", message)
        .set("content.title", status)
        .set("style.classes", "qtip-shadow qtip-#{statusClass}")
        .show()

    switch status
      when "Fetching"
        @statusIndicator.removeClass('error').addClass(statusClass)
      when "Error"
        @statusIndicator.removeClass('fetching').addClass(statusClass)
        displayQtip status, message
      else
        @inputEl.qtip("api").hide()
        @statusIndicator.removeClass('fetching error')
  
  # Fetches information about a repository from the Github API
  fetchInfoFromGithubAPI: (repositoryFullName, callback) ->
    $.getJSON "https://api.github.com/repos/"+repositoryFullName, (info) ->
      callback null, info
    .fail (e) -> 
      if e.status == 404
        callback new Error "Repository <b>#{repositoryFullName}</b> not found."
      else
        callback new Error "Network error when trying to get information about <b>#{repositoryFullName}</b>."
  
  # Generates a message showing that a repository is already licensed
  repositoryLicense: (repositoryFullName, license) ->
    foundLicense = window.licenses.find (lic) -> lic.spdx_id == license.spdx_id
    if foundLicense # Links the license to its page on this site
      "The repository <b> #{repositoryFullName}</b> is already licensed under the 
        <a href='/licenses/#{foundLicense.spdx_id.toLowerCase()}'><b>#{foundLicense.title}</b></a>."
    else
      "The repository <b> #{repositoryFullName}</b> is already licensed."

class AnnotationHighlighter
  constructor: (@ruleElements, @licenseTextElement) ->
    @activeRuleElement = null    
    @translateJQueryObjects()
    if (@browserIsSupported)
      ranges = @extractRanges()
      @bindEvents(ranges)
    else # browser not supported, don't break user expectations
      @removeAnnotationSupport()

  # translate jQuery objects to the native ones
  translateJQueryObjects: =>
    @ruleElements = if Array.isArray(@ruleElements) then @ruleElements else @ruleElements.toArray()
    @licenseTextElement = if @licenseTextElement instanceof Element then @licenseTextElement else @licenseTextElement.get()[0]
  
  removeAnnotationSupport: =>
    @ruleElements.forEach (element) -> element.classList.remove("annotated-rule")
  
  browserIsSupported: =>
    return document.createRange != undefined
  
  # @todo: deal with possible overlapping ranges associated with the same ruleElement
  extractRanges: =>
    rangeRegexp = /([0-9]+)\-([0-9]+)/
    return @ruleElements.reduce (ranges, ruleElement) =>
      try
        ruleElement
          .getAttribute "data-rule-ranges"
          .split ","
          .map (value) =>
            try
              return rangeRegexp.exec value
                .map (part) => parseInt part
            catch
              return null
          .filter (range) => range != null
          .forEach ([_, start, end]) =>
            [start, end] = if start > end then [end, start] else [start, end]
            ranges.push {start, end, ruleElement}
      catch
        return ranges
      return ranges
    , []
  
  bindEvents: (ranges) =>
    annotatedRuleElements = @ruleElements
      .filter (ruleElement) => ruleElement.classList.contains('annotated-rule')

    @ruleElements.forEach (ruleElement) =>
      if (annotatedRuleElements.find (el) => el == ruleElement)
        rangesOfRule = ranges.filter (range) => range.ruleElement == ruleElement
        $(ruleElement).on "click", (e) => 
          e.stopPropagation()
          if @activeRuleElement != ruleElement
            @clearActiveRuleElement()
            @highlightRanges(rangesOfRule, ruleElement)
            @setActiveRuleElement(ruleElement)
          else
            @clearActiveRuleElement()
    
    $('body').on 'click', @clearActiveRuleElement

  clearActiveRuleElement: =>
    @restoreLicenseOriginalFormatting()
    @ruleElements.forEach (el) => el.classList.remove('active')
    @activeRuleElement = null

  setActiveRuleElement: (ruleElement) =>
    ruleElement.classList.add('active')
    @activeRuleElement = ruleElement

  restoreLicenseOriginalFormatting: =>
    @licenseTextElement.innerHTML = @licenseTextElement.textContent;
  
  highlightRanges: (rangesOfRule, ruleElement) =>
    @restoreLicenseOriginalFormatting()
    rangesOfRule
      # create an array of DOM Range objects
      .map ({start, end}) =>
        range = document.createRange()
        range.setStart(@licenseTextElement.childNodes[0], start)
        range.setEnd(@licenseTextElement.childNodes[0], end)
        return range; 
      # do the highlight by surrounding the ranges of text with a <dfn> tag
      .forEach (range) =>
        dfnTag = document.createElement("dfn")
        dfnTag.classList.add(ruleElement.classList[0])
        range.surroundContents(dfnTag);
  
$ ->
  new Choosealicense()
