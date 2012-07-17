class Presentation

  constructor: ->
    @animation = ''
    $window = $(window)
    $document = $(document)
    $example = $('#example')
    $zone = $('#zone')
    $square = $('#square')

    # Syntax Highlight
    $('pre code').not('[contentEditable]').each (i, elem) ->
      hljs.highlightBlock elem

    # Window scroll
    top = $example.offset().top
    $window.on 'scroll', (e) ->
      if window.pageYOffset > top - 54
        if window.pageYOffset > 3141
          $example.addClass 'bottom' unless $example.hasClass('bottom')
        else
          $example.removeClass 'bottom' if $example.hasClass('bottom')
          $example.addClass 'fixed' unless $example.hasClass('fixed')
      else
        $example.removeClass 'fixed' if $example.hasClass('fixed')

    # Example zone management
    $zone.on 'mouseover', (e) =>
      $square.css
        '-webkit-animation': @animation

    $zone.on 'mouseout', (e) =>
      $square.css
        '-webkit-animation': 'none'

    $('[contentEditable]').on 'mouseover', (e) =>
      @current?.removeClass 'current'

      @current = $(e.currentTarget)
      @current.addClass 'current'

      this.setAnimation e.currentTarget

    $('[contentEditable]').on 'blur', (e) =>
      this.setAnimation e.currentTarget

    # Play/Pause
    $span = $('.play-pause span')
    $('.btn-play-pause').on 'click', (e) ->
      value = $(this).data 'value'
      $span.css
        '-webkit-animation-play-state': value

    # Voice syncing
    audio = document.getElementsByTagName('audio')[0]
    $mouth = $('.mouth')
    $('#syncing-play').on 'click', (e) ->
      audio.play()
      $mouth.removeClass 'animated'
      setTimeout ->
        $mouth.addClass 'animated'
      , 0

  setAnimation: (elem) ->
    content = elem.innerHTML
    content = content.replace '-webkit-animation: ', ''
    content = content.replace ';', ''
    @animation = content


# Utils
Number::range = (min, max) ->
  if this < min then min else if this > max then max else this

# Initialization
new Presentation
