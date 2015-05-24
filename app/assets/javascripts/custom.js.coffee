$ ->
  flashCallback = ->
    $(".alert").slideUp(500)
  $(".alert").bind 'click', (ev) =>
    $(".alert").slideUp(500)
  setTimeout flashCallback, 3000