# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$('#body_preview').height($('#announcement_body').height())

body_preview_update_timer = null;

$('#announcement_body').keyup ->
  body_preview_update_timer = setTimeout updatePreview, 500 unless body_preview_update_timer

updatePreview = ->
  $.post '/announcements/preview', { text: $('#announcement_body').val() }, (data) ->
    $('#body_preview').html(data.text)
    body_preview_update_timer = null
updatePreview()
