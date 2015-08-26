@init_panel_time = ->
  update_time = ->
    $('.date-week-time')
    get_time()

  show = (result)->
    $('.date-week-time').text(result)
    timer = setTimeout(update_time, 20 * 1000)

  get_time = ->
    $.ajax
      url: '/time'
      error: (jqXHR, textStatus, errorThrown) ->

      success: (data, textStatus, jqXHR) ->
        result = "#{data.date}, #{data.current_week}, #{data.time}"
        show(result)

  get_time()