class @Utility
  constructor: () ->
  @gearMap: (gear) ->
    if gear == 0
      'R'
    else if gear == 1
      'N'
    else
      gear - 1
  @msToKmh: (ms) ->
    ms * 3.6
  @roundTo: (float, places) ->
    parseFloat(float).toFixed(places)
  @format_ms: (s) ->
    ms = s % 1000
    s = (s - ms) / 1000
    secs = s % 60
    s = (s - secs) / 60
    mins = s % 60
    hrs = (s - mins) / 60

    str = "#{mins}:#{secs}.#{ms.toString().charAt(0)}"

    if hrs > 0
      "#{hrs}:" + str
    else
      str