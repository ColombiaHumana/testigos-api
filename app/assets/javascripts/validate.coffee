# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  if self != top
    $('.top-bar').remove()
  $("#user_phone").mask("(999) 999-9999");
  $('#ver_contra').on 'click', ->
    console.log("click")
    if $('#contra').attr('type') == 'password'
      $('#contra').attr('type', 'text')
    else
      $('#contra').attr('type', 'password')
  $('.edit').on 'click', ->
    $('.editable').prop('disabled', false)
    $('.editable').css('color', '#333')
