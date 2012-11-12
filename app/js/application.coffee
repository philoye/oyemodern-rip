animateProducts =
  time: 2000
  photoHeight: 240
  pageGap:  { top: -160, right: 0, bottom: 0, left: -160 }
  imageGap: { top: -200, right: 400, bottom: 400, left: -400 }
  $currentImage: null

  init: ->
    @run()

  fisherYates: (arr) ->
    i = arr.length
    if i == 0 then return false
    while --i
        j = Math.floor(Math.random() * (i+1))
        tempi = arr[i]
        tempj = arr[j]
        arr[i] = tempj
        arr[j] = tempi
    return arr

  roomToAnimate: ->
    @$page = $('.page')
    offset = @$page.offset()
    @spaceVertically   = offset.top > 200
    @spaceHorizontally = offset.left > 200
    return @spaceVertically or @spaceHorizontally

  showImage: (imgPath) ->
    position = @randomXY()
    $img = $('<img>')
      .addClass('animated_image')
      .attr('src', imgPath)
      .css('top',  position.y)
      .css('left', position.x)
      .appendTo('body')
      .fadeTo(300,1)
    setTimeout =>
      @hideImage $img
    , 3000
    @$currentImage = $img

  hideImage: ($img) ->
    $img.fadeTo 900, 0, ->
      $img.remove()

  field: ->
    x1 = 0
    y1 = 0
    x2 = $(window).width() - (@photoHeight)
    y2 = $(window).height() - (@photoHeight)
    return { x1: x1, y1: y1, x2: x2, y2: y2 }

  calcXYRange: ( $target, gap ) ->
    return [x: 0, y: 0] unless $target
    targetOffset = $target.offset()
    targetOffset.left = Math.floor(targetOffset.left)
    targetOffset.top  = Math.floor(targetOffset.top)
    objX1 = targetOffset.left + gap.left
    objY1 = targetOffset.top  + gap.top
    objX2 = targetOffset.left + $target.width()  + gap.right
    objY2 = targetOffset.top  + $target.height() + gap.bottom
    objRangeX = (px for px in [objX1 .. objX2  ])
    objRangeY = (px for px in [objY1 .. objY2 ])
    return { x: objRangeX, y: objRangeY }

  randomXY: ->
    fieldRange =
      x: (px for px in [@field().x1 .. @field().x2 ])
      y: (px for px in [@field().y1 .. @field().y2 ])
    pageRange = @calcXYRange( @$page, @pageGap )
    imgRange  = @calcXYRange( @$currentImage, @imageGap )

    if @spaceVertically # pick an arbitray x, and compute y
      x = fieldRange.x[Math.floor(Math.random() * fieldRange.x.length)]
      if _.indexOf(pageRange.x, x)
        fieldRange.y = _.difference(fieldRange.y, pageRange.y)
      if _.indexOf(imgRange.x, x)
        fieldRange.y = _.difference(fieldRange.y, imgRange.y)
      y = fieldRange.y[Math.floor(Math.random() * fieldRange.y.length)]
    else # we must have horizontal room, so let's pick an arbitray y and then find x
      y = fieldRange.x[Math.floor(Math.random() * fieldRange.y.length)]
      if _.indexOf(pageRange.y, y)
        fieldRange.x = _.difference(fieldRange.x, pageRange.x)
      if _.indexOf(imgRange.y, y)
        fieldRange.x = _.difference(fieldRange.x, imgRange.x)
      x = fieldRange.x[Math.floor(Math.random() * fieldRange.x.length)]
    return {x: x, y: y}

  randomBetween: (floor, ceiling) ->
    Math.floor(Math.random()*(ceiling-floor+1)+floor)

  index: 0
  run: ->
    imageArray = @fisherYates(window.imageArray)
    setInterval =>
      if @roomToAnimate()
        @showImage(imageArray[@index])
        @index = (@index + 1) % imageArray.length
    , 2000


$(window).load ->
  if $(window).width() >= 768
    animateProducts.init()
