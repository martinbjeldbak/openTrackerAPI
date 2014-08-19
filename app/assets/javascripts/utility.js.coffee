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