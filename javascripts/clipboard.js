$(document).ready(function() {

  // Backup the clipboard button's original text.
  $("#clipboard-button").data('clipboard-prompt', $('#clipboard-button').text());
  
  // Hook up copy to clipboard buttons
  var clip = new ZeroClipboard( $("#clipboard-button"), {
    moviePath: "../../javascripts/ZeroClipboard.swf"
  } );

  clip.on( 'mouseover', function(client, args) {
    // Restore the clipboard button's original text.
    this.innerText = $(this).data('clipboard-prompt');
  } );

  clip.on( 'complete', function(client, args) {
    this.innerText = 'Copied!';
  } );

});