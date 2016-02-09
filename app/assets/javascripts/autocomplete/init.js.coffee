@init_autocomplete = ->

  input = $('.js-autocomplete')
  target = $('.js-autocomplete-target')

  #return if !input.length || !target.length

  input.autocomplete
    source: input.data('url')
    minLength: 2
    select: (event, ui) ->
      target.val(ui.item.id)
      return

  super_ajax = (input) ->
    d = ''
    console.log input
    console.log input.data("url")
    $.ajax url: input.data("url"), async: false,  success: (data) ->
      d = $.map data,(object) ->
        return {value: object.id, label: object.title}
    return d

  autocomplete = (input, target) ->
    input.autocomplete(
      source: super_ajax(input)
      minLength: 2
      focus: (event, ui) ->
        $(input).val ui.item.label
        return false
      select: (event, ui) ->
        button_disabler $(".js-role-input")
        $(target).val ui.item.value
        return false
    ).autocomplete("instance")._renderItem = (ul, item) ->
      console.log ul.attr "class"
      $("<li>")
        .append(item.label)
        .appendTo(ul)

  button_disabler = (input) ->
    button = $(".js-submit-button")
    role_input = input
    if role_input.val() == "manager" && $(".js-autocomplete-subdivisions").val() == ""
      button.addClass("disabled")
      $(".js-autocomplete-subdivisions").slideDown("slow")
    else if role_input.val() == "manager" && $(".js-autocomplete-subdivisions").val() != ""
      button.removeClass("disabled")
      $(".js-autocomplete-subdivisions").slideDown("slow")
    else if role_input.val() != "manager"
      $(".js-autocomplete-subdivisions-target").val ""
      $(".js-autocomplete-subdivisions").val ""
      $(".js-autocomplete-subdivisions").slideUp("slow")
    else
      button.removeClass("disabled")
      $(".js-autocomplete-subdivisions").slideUp("slow")





  autocomplete $(".js-autocomplete-subdivisions"),  $(".js-autocomplete-subdivisions-target")

  input = $(".js-role-input")
  input.change ->
    button_disabler $(this)
  $(".js-autocomplete-subdivisions").change ->
    button_disabler input
  button_disabler(input)


  return
