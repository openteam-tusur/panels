$ ->

  init_autocomplete() if $('.js-autocomplete').length
  init_chosen() if $('.js-entry-context-chosen')

  $('a.disabled').click ->
    return false
