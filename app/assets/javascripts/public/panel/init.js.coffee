@init_panel = ->

  url = window.location.href
  slide = $('.data').data('id')
  timeout = $('.data').data('timeout')

  update_panel = ->
    $.ajax
      url: url
      data: { current: slide }
      error: (jqXHR, textStatus, errorThrown) ->
        clearTimeout(timer)
        $('.data').hide().html(jqXHR.responseText)
        $('.data').css('white-space', 'pre').fadeIn()
        console.error errorThrown if console && console.error
        return
      success: (data, textStatus, jqXHR) ->
        response = $('<div />').html(data)
        slide = $('.data', response).data('id')
        timeout = $('.data', response).data('timeout')
        $('.data').fadeOut ->
          $('.data').replaceWith(response.html())
          $('.data').hide().fadeIn()
        timier = setTimeout update_panel, timeout * 1000
        return

  timer = setTimeout update_panel, timeout * 1000

  return
