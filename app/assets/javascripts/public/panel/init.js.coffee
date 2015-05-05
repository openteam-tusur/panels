@init_panel = ->

  url = window.location.href
  slide = $('.data').data('id')
  timeout = $('.data').data('timeout')

  update_panel = ->
    $.ajax
      url: url
      data: { current: slide }
      error: (jqXHR, textStatus, errorThrown) ->
        console.error errorThrown if console && console.error
        return
      success: (data, textStatus, jqXHR) ->
        response = $('<div />').html(data)
        slide = $('.data', response).data('id')
        timeout = $('.data', response).data('timeout')
        $('.data').fadeOut ->
          $('.data').replaceWith(response.html())
          $('.data').hide().fadeIn()
        setTimeout update_panel, timeout * 1000
        return

  setTimeout update_panel, timeout * 1000

  return
