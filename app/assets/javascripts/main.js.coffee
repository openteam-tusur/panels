$ ->

  init_autocomplete() if $('.js-autocomplete').length

  $('a.disabled').click ->
    return false
