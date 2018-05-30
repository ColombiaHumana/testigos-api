# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  $.get '/departments', (data) ->
    $("#user_department").find('option').not(':first').remove()
    $.each data, (key, value) ->
      $("#user_department").append('<option value=' + value['id'] + '>' + value['name'] + '</option>')
  $('#user_department').on "change", ->
    url = '/municipalities/' + $(this).val() + '.json'
    $("#user_municipality").find('option').not(':first').remove()
    $.get url, (data) ->
      $.each data, (key, value) ->
        $("#user_municipality").append('<option value=' + value['id'] + '>' + value['name'] + '</option>')
  $('#user_municipality').on "change", ->
    url = '/zones/' + $(this).val() + '.json'
    $("#user_zone").find('option').not(':first').remove()
    $.get url, (data) ->
      $.each data, (key, value) ->
        $("#user_zone").append('<option value=' + value['id'] + '>' + value['name'] + '</option>')
  $('#user_zone').on "change", ->
    url = '/posts/' + $(this).val() + '.json'
    $("#user_post_id").find('option').not(':first').remove()
    $.get url, (data) ->
      $.each data, (key, value) ->
        $("#user_post_id").append('<option value=' + value['id'] + '>' + value['name'] + '</option>')
