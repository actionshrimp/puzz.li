$('#key-catcher').focus((e) ->
  $('.puzzle-grid').addClass('puzzle-grid-focused')
)

$('#key-catcher').blur((e) ->
  $('.puzzle-grid').removeClass('puzzle-grid-focused')
)

$('#puzzle').click((e) ->
  $('#key-catcher').focus()
)

$(document).ready(->
  $('#key-catcher').focus()
)
