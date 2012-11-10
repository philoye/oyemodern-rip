fisherYates = (arr) ->
    i = arr.length
    if i == 0 then return false
    while --i
        j = Math.floor(Math.random() * (i+1))
        tempi = arr[i]
        tempj = arr[j]
        arr[i] = tempj
        arr[j] = tempi
    return arr

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
  pageGap:  { top: -160, right: 160, bottom: 0, left: -160 }
  imageGap: { top: -200, right: 400, bottom: 400, left: -400 }
  $currentImage: null

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
    position = @randomXY()
    $li.css('top',  position.top)
    $li.css('left', position.left)
    $img.css('opacity',1)
    @$currentImage = $img
    setTimeout =>
      @hideImage $img
    , 3000

  hideImage: ($img) ->
    $img.css('opacity',0)

  field: ->
    x1 = 0
    y1 = 0
    x2 = $(window).width() - (@photoHeight / 3 * 2)
    y2 = $(window).height() - (@photoHeight / 3 * 2)
    return { x1: x1, y1: y1, x2: x2, y2: y2 }

  detectCollision: (x, y, $target, gap) ->
    return false unless $target
    objX1 = $target.offset().left + gap.left
    objY1 = $target.offset().top  + gap.top
    objX2 = $target.offset().left + $target.width() + gap.right
    objY2 = $target.offset().top  + $target.height() + gap.bottom
    collision = ((x > objX1) and (x < objX2) and (y > objY1) and (y < objY2))
    return collision

  randomXY: ->
    collision = true
    while collision
      x = @randomBetween( @field().x1, @field().x2 )
      y = @randomBetween( @field().y1, @field().y2 )
      collidePage = @detectCollision(x, y, $('.page'), @pageGap )
      collideImage = @detectCollision(x, y, @$currentImage, @imageGap)
      collision = collidePage or collideImage
    return { left: x, top: y }

  randomBetween: (floor, ceiling) ->
    Math.floor(Math.random()*(ceiling-floor+1)+floor)

  run: ->
    fisherYates(@$items).each (index, element) =>
      setTimeout =>
        @showImage element
      , @time
      @time += 4000

$ ->
  #$('.email').deobfuscate()

$(window).load ->
  if $(window).width() >= 768
    animateProducts.init()
