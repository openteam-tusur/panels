@init_panel_time = ->

  update_datetime = ->
    $.ajax
      url: '/datetime'
      success: (data, textStatus, jqXHR) ->
        return if data.date == undefined || data.time == undefined
        $('.date-week-time .date').text("#{data.date},")
        $('.date-week-time .time').text("#{data.time}")
        return

    return

  setInterval ->
    update_datetime()
    return
  , 10 * 1000 # every 10 seconds

  update_datetime()

  update_week = ->
    $.ajax
      url: '/week'
      success: (data, textStatus, jqXHR) ->
        return if data.week == undefined
        $('.date-week-time .week').text("#{data.week},")
        return

    return

  setInterval ->
    update_week()
    return
  , 60 * 60 * 1000 # every 1 hours

  update_week()

  return
