# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  $('#ver_contra').on 'click', ->
    console.log("click")
    if $('#contra').attr('type') == 'password'
      $('#contra').attr('type', 'text')
    else
      $('#contra').attr('type', 'password')
