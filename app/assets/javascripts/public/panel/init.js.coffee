@init_panel = ->
  # important variables and constants initialization in main function body
  VIDEO_PROPORTION = 1.7777777777777777 # this is just 16 / 9
  timeout = 0
  slide = ''
  cutaway = ''
  recent_played_entry = ''


  #common functions declaration:
  init_progressbar = (timeout) ->
    $('#progressbar').html('')
    line = new ProgressBar.Line '#progressbar',
      color: '#ccc'
      duration: timeout
    line.animate(1)
    return

  update_panel = ->
    $.ajax
      url: url
      data: {
        current_slide: slide
        current_cutaway: cutaway
        recent_played_entry: recent_played_entry
      }
      error: (jqXHR, textStatus, errorThrown) ->
        $('.data').fadeOut ->
          $('.data').addClass('error').html('<div class=\'table-cell\'><h1>Сервис временно недоступен</h1></div>').hide().fadeIn()
        timeout = 350
        init_progressbar(timeout * 1000)
        timer = setTimeout update_panel, timeout * 1000
        return
      success: (data, textStatus, jqXHR) ->
        response = $('<div />').html(data)
        timeout = $('.data', response).data('timeout')
        $('.data').fadeOut ->
          $('.data').replaceWith(response.html())
          $('.data').hide().fadeIn()
          entry = recent_played_entry()
          slide = $('.data').data('id') if entry == 'entry'
          cutaway = cutaway_updater() if $('#cutaway').length
          detect_content_type()
          onYouTubeIframeAPIReady() if $('#player').length
          return
        return

  slide_start = ->
    init_progressbar(timeout * 1000)
    timer = setTimeout update_panel, timeout * 1000
    return

  fade_in_content = (object) ->
    object.fadeIn(400)
    return

  content_height = ->
    $(window).height() - $('nav').height() - $('.title').height() - $('.em').height() * 4

  detect_content_type = ->
    if $("#player").length
      init_youtube()
    else if $('#photo-container').length || $('#cutaway').length
      init_photo()
    else if $('.text-container').length
      init_text()



  #content-specified functions declaration:
  #for a photo and cutaway slides:
  init_photo = ->
    url = $('#hidden').text()
    original_sizes = /\d+-\d+/.exec(url).join().split('-')
    image_proportion = original_sizes[0]/original_sizes[1]
    image_height = Math.floor(content_height())
    image_width = Math.floor(image_height * image_proportion)
    url = url.replace(/\d+-\d+/, "#{image_width}-#{image_height}").compact()
    img = $('<img>', { src: url}).attr('class', 'photo')
    $('#photo-container').html(img)
    fade_in_content($('#photo-container'))
    $('.title').css('display', 'none').css('visibility', 'visible')
    $('.title').css('width', image_width).css('margin-left', ($(window).width() - image_width)/2 ).fadeIn(400)
    slide_start()

  #text functions:
  init_text = ->
    $('.data').css('height', content_height())
    fade_in_content($('.wrapper'))
    slide_start()


  #video functions
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
      margins_for_video()
      event.target.playVideo()
      return

    onPlayerStateChange = (event) ->
      if event.data == YT.PlayerState.PLAYING
        init_progressbar(timeout * 1000)
        localStorage.slide = slide
        setTimeout (()->
            update_panel() if parseInt(localStorage.slide) == parseInt(slide)
          ), timeout * 1000
      else if event.data == YT.PlayerState.ENDED
        localStorage.slide = null
        update_panel()
      return

    window.onYouTubeIframeAPIReady = onYouTubeIframeAPIReady
    return

  player_sizes = ->
    height = Math.floor(content_height())
    width = Math.floor(height * VIDEO_PROPORTION)
    {
      height: height
      width: width
    }

  margins_for_video = ->
    margin_left = ($(window).width() - $('.player').width())/2
    $('.content-container').css('margin-left', "#{margin_left}px")

    margin_top = ($('body').height() - $('nav').height() - $('.player').height())/3
    $('.content-container').css('margin-top', "#{margin_top}px")

    $('.title').css('display', 'none').css('visibility', 'visible')
    $('.title').css('width', $('.player').width()).css('margin-left', margin_left)

    fade_in_content($('#video-container'))
    fade_in_content($('.title'))


  #functions for cutaway functional realisation
  cutaway_updater = -> $('#cutaway').data('id')

  recent_played_entry = -> if $('#cutaway').length then 'cutaway' else 'entry'


  url = window.location.href
  slide = $('.data').data('id')
  timeout = $('.data').data('timeout')

  #starting cycle of ajax remove-load-prepare-start functions
  detect_content_type()
