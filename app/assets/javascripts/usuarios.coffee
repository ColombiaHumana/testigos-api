$(document).ready ->
  $.get '/departments', (data) ->
    $("#department").find('option').not(':first').remove()
    $("#municipality").find('option').not(':first').remove()
    $("#zone").find('option').not(':first').remove()
    $("#post_id").find('option').not(':first').remove()
    $.each data, (key, value) ->
      $("#department").append('<option value=' + value['id'] + '>' + value['name'] + '</option>')
  $('#department').on "change", ->
    url = '/municipalities/' + $(this).val() + '.json'
    $("#municipality").find('option').not(':first').remove()
    $("#zone").find('option').not(':first').remove()
    $("#post_id").find('option').not(':first').remove()
    $.get url, (data) ->
      $.each data, (key, value) ->
        $("#municipality").append('<option value=' + value['id'] + '>' + value['name'] + '</option>')
  $('#municipality').on "change", ->
    url = '/zones/' + $(this).val() + '.json'
    $("#zone").find('option').not(':first').remove()
    $("#post_id").find('option').not(':first').remove()
    $.get url, (data) ->
      $.each data, (key, value) ->
        $("#zone").append('<option value=' + value['id'] + '>' + value['name'] + '</option>')
  $('#zone').on "change", ->
    url = '/posts/' + $(this).val() + '.json'
    $("#post_id").find('option').not(':first').remove()
    $.get url, (data) ->
      $.each data, (key, value) ->
        $("#post_id").append('<option value=' + value['id'] + '>' + value['name'] + '</option>')


  $('#save_post').on 'click', ->
    $.post '/admin/users/'+$('#user_id').val()+'/save_post',{post_id: $('#post_id').val()}, (data) ->
      alert("Puesto guardado");
  $('#save_email').on 'click', ->
    $.post '/admin/users/'+$('#user_id').val()+'/save_email',{email: $('#email').val()}, (data) ->
      alert("Email guardado");
