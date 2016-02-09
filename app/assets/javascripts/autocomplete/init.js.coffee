@init_autocomplete = ->

  input = $('.js-autocomplete')
  target = $('.js-autocomplete-target')

  return if !input.length || !target.length

  input.autocomplete
    source: input.data('url')
    minLength: 2
    select: (event, ui) ->
      target.val(ui.item.id)
      return

  button_disabler = ->
    button = $(".js-submit-button")
    input = $(".js-entry-context-chosen")
    if $(".js-role-input").val() == "manager" && input.val() == ""
      $(".permission_context_id").slideDown "fast"
      button.addClass("disabled")
    else if $(".js-role-input").val() == "manager"
      $(".permission_context_id").slideDown "fast"
      button.removeClass("disabled")
    else if $(".js-role-input").val() != "manager"
      $(".permission_context_id").slideUp "fast"
      button.removeClass("disabled")






  $(".js-role-input").change ->
    button_disabler()
  $(".js-entry-context-chosen").change ->
    button_disabler()

  button_disabler()


  return
