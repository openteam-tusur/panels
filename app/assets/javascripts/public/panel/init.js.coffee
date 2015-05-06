@init_panel = ->

  url = window.location.href
  slide = $('.data').data('id')
  timeout = $('.data').data('timeout')

  init_progressbar = (timeout) ->
    $('#progressbar').html('')
    line = new ProgressBar.Line '#progressbar',
      color: '#fcb03c'
      duration: timeout
    line.animate(1)
    return

  update_panel = ->
    $.ajax
      url: url
      data: { current: slide }
      error: (jqXHR, textStatus, errorThrown) ->
        $('.data').fadeOut ->
          $('body').addClass('error')
          $('.data').html('<h1>Сервис временно недоступен</h1>').hide().fadeIn()
        timeout = 350
        init_progressbar(timeout * 1000)
        timier = setTimeout update_panel, timeout * 1000
        return
      success: (data, textStatus, jqXHR) ->
        $('body').removeClass('error')
        response = $('<div />').html(data)
        slide = $('.data', response).data('id')
        timeout = $('.data', response).data('timeout')
        $('.data').fadeOut ->
          $('.data').replaceWith(response.html())
          $('.data').hide().fadeIn()
          init_progressbar(timeout * 1000)
          timier = setTimeout update_panel, timeout * 1000
          return
        return

  init_progressbar(timeout * 1000)
  timer = setTimeout update_panel, timeout * 1000

  return
