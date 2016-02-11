$ ->

  init_autocomplete() if $('.js-autocomplete').length
  init_chosen() if $('.js-entry-context-chosen')
  init_documentation() if $('.documentation').length > 0


  $('a.disabled').click ->
    return false
