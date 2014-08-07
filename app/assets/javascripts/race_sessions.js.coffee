position_linear_scale = d3.scale.linear().domain([-1000, 1000]).range([0, 750])

class Canvas
  constructor: (@container) ->
    @pointer = @container.append('circle').attr('cx', 0).attr('cy', 0).attr('r', 10)
  updatePosition: (x, y) ->
    @pointer.transition().attr('cx', x).attr('cy', y)

jQuery ->
  svgContainer = d3.select('#race-sess-canvas svg')
  $canvas = $('#race-sess-canvas')
  $race_session_id = $canvas.data('race-session')


  drawing = new Canvas svgContainer

  dispatcher = new WebSocketRails('localhost:3000/websocket')
  console.log('Subscribing to ' + "race_session_#{$race_session_id}_positions")
  channel = dispatcher.subscribe("race_session_#{$race_session_id}_positions")
  channel.bind('create', (data) ->
    console.log("#{data.x} and #{data.y} and #{data.z}")
    drawing.updatePosition(position_linear_scale(data.x), position_linear_scale(data.z))
  )