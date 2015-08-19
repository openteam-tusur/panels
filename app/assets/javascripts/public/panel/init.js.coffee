@init_panel = ->
  VIDEO_PROPORTION = 1.7777777777777777 # this is 16 / 9
  timeout = 0
  #without it progressbar cannot get actual timeout

  init_progressbar = (timeout) ->
    $('#progressbar').html('')
    line = new ProgressBar.Line '#progressbar',
      color: '#ccc'
      duration: timeout
    line.animate(1)
    return

  init_youtube = ->
    onYouTubeIframeAPIReady = ->
      #new object for YouTubeIframeAPI 
      sizes = player_sizes()
      player = new (YT.Player)('player',
        videoId: $("#player").data('value')
        width:  sizes.width
        height: sizes.height
        playerVars:
          controls: 0 # hide control elements of player
          rel:      0 # do not show related videos after clip end
          showinfo: 0 # hide info shown before video started
        events:
          'onReady': onPlayerReady
          'onStateChange': onPlayerStateChange
       )
      return

    onPlayerReady = (event) ->
      margin()
      event.target.playVideo()
      return

    onPlayerStateChange = (event) ->
      if event.data == YT.PlayerState.PLAYING
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
          video_or_not()
          onYouTubeIframeAPIReady() if $("#player")
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

  player_sizes = -> 
    height = $(window).height() - $('nav').height() - $('strong').height() - 100
    width = height * VIDEO_PROPORTION
    {
      height: height
      width: width
    }

  margin = ->
    margin_left = ($(window).width() - $('.player').width())/2
    $('.content-container').css('margin-left', "#{margin_left}px")

    margin_top = ($('body').height() - $('nav').height() - $('.player').height())/3
    $('.content-container').css('margin-top', "#{margin_top}px")

    $('.content-container').fadeIn(400)

  url = window.location.href
  slide = $('.data').data('id')
  timeout = $('.data').data('timeout')

  video_or_not()