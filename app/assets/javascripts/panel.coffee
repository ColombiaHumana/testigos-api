$(document).ready ->
  $('input[type=number]').bind 'keypress', (e) ->
    keycode = if (e.which) then e.which else e.keyCode
    !(keycode > 31 and (keycode < 48 or keycode > 57))
  $(document).on 'change', '.masq', ->
    suma_total_validos = 0
    suma_total_mesa = 0
    total_mesa = parseInt($('#round_votes_total_urna').val())
    $('.votos_validos').each ->
      suma_total_validos += +$(this).val()
    $('.total_validos').val suma_total_validos
    $('.campos').each ->
      suma_total_mesa += +$(this).val()
    $('.total_mesa').val suma_total_mesa
    if total_mesa != suma_total_mesa or suma_total_mesa == 0
      $('#b_env').prop('disabled', true)
      $('#warn_suma').show()
    else
      $('#b_env').removeAttr('disabled')
      $('#warn_suma').hide()
