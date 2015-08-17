@init_panel = ->

  timeout = 0
  #мистика, но без этого прогрессбар не работает корректно
  
  init_progressbar = (timeout) ->
    $('#progressbar').html('')
    line = new ProgressBar.Line '#progressbar',
      color: '#ccc'
      duration: timeout
    line.animate(1)
    return

  init_youtube = ->
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

    onPlayerReady = (event) ->
      event.target.playVideo()
      return

    onPlayerStateChange = (event) ->
      if event.data == YT.PlayerState.PLAYING
        console.log "timeout is a " + timeout
        init_progressbar(timeout * 1000)
      else if event.data == YT.PlayerState.ENDED
        update_panel()
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
        timer = setTimeout update_panel, timeout * 1000
        return
      success: (data, textStatus, jqXHR) ->
        response = $('<div />').html(data)
        slide = $('.data', response).data('id')
        timeout = $('.data', response).data('timeout')
        $('.data').fadeOut ->
          $('.data').replaceWith(response.html())
          $('.data').hide().fadeIn()
          console.log timeout
          video_or_not()
          onYouTubeIframeAPIReady() if $("#player")
          onYouTubeIframeAPIReady()
          return
        return

  slide_start = ->
    init_progressbar(timeout * 1000)
    timer = setTimeout update_panel, timeout * 1000  
    return

  video_or_not = ->
    if $("#player")
      init_youtube() 
    else
      slide_start()

  url = window.location.href
  slide = $('.data').data('id')
  timeout = $('.data').data('timeout')
  video_or_not()
