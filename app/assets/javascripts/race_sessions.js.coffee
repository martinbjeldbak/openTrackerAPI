gearMap = (gear) ->
  if gear == 0
    'R'
  else if gear == 1
    'N'
  else
    gear - 1

msToKmh = (ms) ->
  ms * 3.6

roundTo = (float, places) ->
  parseFloat(float).toFixed(places)

class Map
  constructor: (@container) ->
    @lineFunction = d3.svg.line().x((d) -> d.x ).y((d) -> d.y).interpolate('linear')
    @data = new Array
  updatePosition: (x, y) ->
    @data.push {x: x, y: y}
    @container.select('#player_path').remove()
    @container.append('path').attr('d', @lineFunction(@data)).style('stroke-width', 2)
      .style('stroke', 'steelblue').attr('fill', 'none').attr('id', 'player_path')

jQuery ->
  svgContainer = d3.select('#race-sess-canvas svg')
  $canvas = $('#race-sess-canvas')

  reduction_ratio = 0.5
  actual_map_width = 599.505
  actual_map_height = 256.251
  x_offset = 20
  z_offset = 20
  map_width = actual_map_width * reduction_ratio
  map_height = actual_map_height * reduction_ratio


  $canvas.width(map_width).height(map_height)

  $race_session_id = $canvas.data('race-session')

  # Functions to scale given x and y coordinates down to the svg container's size
  position_linear_scale_x = d3.scale.linear().domain([0, actual_map_width]).range([0, map_width])
  position_linear_scale_y = d3.scale.linear().domain([0, actual_map_height]).range([0, map_height])

  drawing = new Map svgContainer

  # Subscribe to websocket info
  dispatcher = new WebSocketRails 'localhost:3000/websocket'
  channel = dispatcher.subscribe("race_session_#{$race_session_id}_positions")

  updateSessionAttributes = (data) ->
    # Update attributes on page
    $('span.race-sess-speed').text(roundTo(msToKmh(data.speed), 2))
    $('span.race-sess-rpm').text(roundTo(data.rpm, 2))
    $('span.race-sess-gear').text(gearMap(data.gear))

    toggleBinaryLabel($('span.race-sess-on-gas'), roundTo(data.on_gas, 2))
    toggleBinaryLabel($('span.race-sess-on-brake'), roundTo(data.on_brake, 2))

  # Get race_session information and set background to be track
  $.ajax
    url: window.location.pathname
    dataType: 'json'
    success: (data, textStatus, jqXHR) ->
      race_session = data.race_session

      imgs = svgContainer.selectAll('image').data([0])
      imgs.enter().append('svg:image')
        .attr('xlink:href', race_session.track_img_path)
        .attr('height', $canvas.height())
        .attr('width', $canvas.width())


  toggleBinaryLabel = ($elem, val) ->
    $elem.addClass('label')
    $elem.toggleClass('label-success', val > 0.0 )
    $elem.toggleClass('label-danger', val < 0.01)

    if val > 0.01
      $elem.text("#{val * 100}%")
    else
      $elem.text('No')

  # When new position is created
  channel.bind('create', (data) ->
    # Update dot on the map
    drawing.updatePosition(position_linear_scale_x((data.x + x_offset)), position_linear_scale_y(data.z + z_offset))

    #console.log(position_linear_scale_x(data.x + x_offset) + " " + position_linear_scale_y(data.z + z_offset))

    updateSessionAttributes(data)

  )