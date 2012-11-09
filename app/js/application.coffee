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
  init: ->
    @$page = $('page')
    @$items = $('ul.imagegrid li')
    @findZones()


  findZones: ->
    offset = @$page.offset()
    spaceAbove = offset.top > 160
    spaceLeft = offset.left > 160


$ ->
  $('.email').deobfuscate()
  animateProducts.init()
