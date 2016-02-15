$ ->
  $('[data-toggle="tooltip"]').tooltip()
  $(document).on 'nested:fieldAdded',(event) ->
    field = event.field
    dates = field.find(".js-date-picker")
    $('[data-toggle="tooltip"]').tooltip()
    $.map dates, (date) ->
      $(date).datetimepicker
        locale: "ru"
      return


  if $('.js-date-picker').length > 0
    $.map $(".js-date-picker"), (input) ->
      $(input).datetimepicker
        locale: 'ru'
