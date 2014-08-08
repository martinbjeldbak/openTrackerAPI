position_linear_scale = d3.scale.linear().domain([-1000, 1000]).range([0, 750])

gearMap = (gear) ->
  if gear == 0
    'R'
  else if gear == 1
    'N'
  else
    gear - 1

msToKmh = (ms) ->
  ms * 3.6

class Map
  constructor: (@container) ->
    @pointer = @container.append('circle').attr('cx', 0).attr('cy', 0).attr('r', 10)
  updatePosition: (x, y) ->
    @pointer.transition().attr('cx', x).attr('cy', y)

jQuery ->
  svgContainer = d3.select('#race-sess-canvas svg')
  $canvas = $('#race-sess-canvas')
  $race_session_id = $canvas.data('race-session')

  drawing = new Map svgContainer

  dispatcher = new WebSocketRails 'localhost:3000/websocket'
  channel = dispatcher.subscribe("race_session_#{$race_session_id}_positions")

  # When new position is given to us...
  channel.bind('create', (data) ->
    # Update dot on the map
    drawing.updatePosition(position_linear_scale(data.x), position_linear_scale(data.z))

    # Update attributes on page
    $('span.race-sess-speed').text(parseFloat(msToKmh(data.speed)).toFixed(2))
    $('span.race-sess-rpm').text(parseFloat(data.rpm).toFixed(0))
    $('span.race-sess-gear').text(gearMap(data.gear))
  )