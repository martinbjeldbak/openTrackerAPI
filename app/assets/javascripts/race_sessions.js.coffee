RaceSessionsController = Paloma.controller('RaceSessions')

RaceSessionsController.prototype.show = () ->
  class Map
    constructor: (@container) ->
      @lineFunction = d3.svg.line().x((d) -> d.x ).y((d) -> d.y).interpolate('linear')
      @data = new Array
    updatePosition: (x, y) ->
      @data.push {x: x, y: y}
      @container.select('#player_path').remove()
      @container.append('path').attr('d', @lineFunction(@data)).style('stroke-width', 2)
        .style('stroke', 'steelblue').attr('fill', 'none').attr('id', 'player_path')
    scale_x: (from_domain, to_domain) ->
      d3.scale.linear().domain(from_domain).range(to_domain)
    scale_y: (from_domain, to_domain) ->
      d3.scale.linear().domain(from_domain).range(to_domain)

  jQuery ->
    class Lap
      constructor: (@user_id, @session_id, @lap_id) ->
        @lap = @getInfo(@user_id, @session_id, @lap_id)
      getInfo: (user_id, session_id, lap_id) ->
        info = {}
        $.ajax
          url: "/users/#{user_id}/race_sessions/#{session_id}/laps/#{lap_id}"
          dataType: 'json'
          async: false
          success: (data) ->
            info = data.lap
        return info
      number: -> @lap.number

    class SessionInfo
      constructor: (@user_id, @session_id) ->
        @session = @getInfo()
        @track = @session.track

      getInfo: ->
        info = {}
        $.ajax
          url: "/users/#{@user_id}/race_sessions/#{@session_id}"
          dataType: 'json'
          async: false
          success: (data) ->
            info = data.race_session
        return info
      scale_factor: ->
        @track.scale_factor
      reduction_ratio: ->
        @track.img_scale
      ac_map_width: ->
        @track.img_width * @scale_factor()
      ac_map_height: ->
        @track.img_height * @scale_factor()
      x_offset: ->
        @track.x_offset
      z_offset: ->
        @track.z_offset
      map_width: ->
        @ac_map_width() * @reduction_ratio()
      map_height: ->
        @ac_map_height() * @reduction_ratio()
      img_path: ->
        @track.img_path


    svgContainer = d3.select('#race-sess-canvas svg')
    $canvas = $('#race-sess-canvas')

    session_info = new SessionInfo $canvas.data('user'), $canvas.data('race-session')


    $canvas.width(session_info.map_width()).height(session_info.map_height())

    $race_session_id = $canvas.data('race-session')

    drawing = new Map svgContainer

    # Functions to scale given x and y coordinates down to the svg container's size
    position_linear_scale_x = drawing.scale_x([0, session_info.ac_map_width()], [0, session_info.map_width()])
    position_linear_scale_y = drawing.scale_y([0, session_info.ac_map_height()], [0, session_info.map_height()])

    # Subscribe to websocket info
    dispatcher = new WebSocketRails 'localhost:3000/websocket'
    channel = dispatcher.subscribe("race_session_#{$race_session_id}_positions")

    updateLapAttributes = (user_id, session_id, lap_id) ->
      lap = new Lap(user_id, session_id, lap_id)
      $('span.race-sess-lap').text(lap.number())


    updateSessionAttributes = (data) ->
      # Update attributes on page
      $('span.race-sess-speed').text(Utility.roundTo(Utility.msToKmh(data.speed), 2))
      $('span.race-sess-rpm').text(Utility.roundTo(data.rpm, 2))
      $('span.race-sess-gear').text(Utility.gearMap(data.gear))


      toggleBinaryLabel($('span.race-sess-on-gas'), Utility.roundTo(data.on_gas, 2))
      toggleBinaryLabel($('span.race-sess-on-brake'), Utility.roundTo(data.on_brake, 2))


    imgs = svgContainer.selectAll('image').data([0])
    imgs.enter().append('svg:image')
      .attr('xlink:href', session_info.img_path())
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
    channel.bind 'create', (data) ->
      # Update dot on the map
      drawing.updatePosition(position_linear_scale_x(data.x + session_info.x_offset()), position_linear_scale_y(data.z + session_info.z_offset()))

      updateSessionAttributes(data)
      updateLapAttributes($canvas.data('user'), $race_session_id, data.lap_id)