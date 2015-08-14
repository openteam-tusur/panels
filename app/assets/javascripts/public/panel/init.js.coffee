@init_panel = ->

  url = window.location.href
  slide = $('.data').data('id')
  timeout = $('.data').data('timeout')


  init_progressbar = (timeout) ->
    $('#progressbar').html('')
    line = new ProgressBar.Line '#progressbar',
      color: '#ccc'
      duration: timeout
    line.animate(1)
    return

  onVideoContent = ->
    onYouTubeIframeAPIReady = ->
      player = new (YT.Player)('player',
        height: '390'
        width: '640'
        videoId: $("#player").data('value')
        events:
          'onReady': onPlayerReady
          'onStateChange': onPlayerStateChange
       )
      return

    onPlayerReady = (event)->
      event.target.playVideo()
      return

    done = false
    onPlayerStateChange = (event)->
      if event.data == YT.PlayerState.PLAYING and !done
        done = true
      return

    stopVideo = ->
      player.stopVideo()
      return

    window.onYouTubeIframeAPIReady = onYouTubeIframeAPIReady
    return

  update_panel = ->
    $.ajax
      url: url
      data: { current: slide }
      error: (jqXHR, textStatus, errorThrown) ->
        $('.data').fadeOut ->
          $('.data').addClass('error').html('<div class=\'table-cell\'><h1>Сервис временно недоступен</h1></div>').hide().fadeIn()
        timeout = 350
        init_progressbar(timeout * 1000)
        timier = setTimeout update_panel, timeout * 1000
        return
      success: (data, textStatus, jqXHR) ->
        response = $('<div />').html(data)
        slide = $('.data', response).data('id')
        timeout = $('.data', response).data('timeout')
        $('.data').fadeOut ->
          $('.data').replaceWith(response.html())
          $('.data').hide().fadeIn()
          init_progressbar(timeout * 1000)
          timier = setTimeout update_panel, timeout * 1000
          onVideoContent() if $("#player")
          onYouTubeIframeAPIReady()
          return
        return

  init_progressbar(timeout * 1000)
  timer = setTimeout update_panel, timeout * 1000
  onVideoContent() if $("#player")