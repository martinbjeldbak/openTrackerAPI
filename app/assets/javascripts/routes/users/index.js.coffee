OpenTracker.UsersIndexRoute = Ember.Route.extend
  model: ->
    OpenTracker.User.findAll()
  #beforeModel: ->
  #  this.transitionTo('index')