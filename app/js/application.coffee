
$.fn.deobfuscate = ->
  $(this).each (i, el) ->
    user = $(this).attr('data-email').replace(/[a-zA-Z]/g, (c) ->
      String.fromCharCode (if ((if c <= "Z" then 90 else 122)) >= (c = c.charCodeAt(0) + 13) then c else c - 26)
    )
    domain = location.host
    address = user + '@' + domain
    link = "<a href=\"mailto:" + address + "\">" + address + "</a>"
    el.innerHTML = link
  return this

animateProducts =
  time: 50
  photoHeight: 240

  init: ->
    @$page = $('page')
    @$items = $('ul.imagegrid li')
    @findZones()
    @run() for [1..20]

  findZones: ->
    $page = $('.page')
    offset     = $page.offset()
    @spaceAbove = offset.top > 200
    @spaceLeft  = offset.left > 200

  showImage: (element) ->
    $li= $(element)
    $img = $li.find('img')
    $li.css('left', @randomXY().left)
    $li.css('top',  @randomXY().top)
    $img.css('opacity',1)
    setTimeout =>
      @hideImage $img
    , 3000

  hideImage: (img) ->
    img.css('opacity',0)

  randomXY: ->
    winH = $(window).height()
    winW = $(window).width()
    pageX1 = $('.page').offset().left - (@photoHeight / 3)
    pageY1 = $('.page').offset().top - (@photoHeight / 3)
    pageX2 = pageX1 + $('.page').width()
    pageY2 = pageY1 + $('.page').height()

    collision = true
    while collision
      x = @randomBetween(0, winW - (@photoHeight / 3))
      y = @randomBetween(0, winH - (@photoHeight / 3))
      if ((x > pageX1) and (x < pageX2) or (y > pageY1) and (y < pageY2))
        console.log 'collision!'
      else
        collision = false
    return { left: x - (@photoHeight / 3), top: y - (@photoHeight / 3) }

  randomBetween: (floor, ceiling) ->
    Math.floor(Math.random()*(ceiling-floor+1)+floor)

  run: ->
    @$items.each (index, element) =>
      setTimeout =>
        @showImage element
      , @time
      @time += 4000

$ ->
  $('.email').deobfuscate()

$(window).load ->
  animateProducts.init()
