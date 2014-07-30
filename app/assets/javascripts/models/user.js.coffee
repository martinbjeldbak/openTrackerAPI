OpenTracker.User = Ember.Object.extend({})

OpenTracker.User.reopenClass
  findAll: ->
    users = Em.A()
    $.getJSON('/api/v1/users').then (data) ->
      Ember.run () ->
        users.pushObjects(data.users)
        users
  find: (id) ->
    $.getJSON("/api/v1/users/#{id}").then (users) ->
      Ember.run () ->
        OpenTracker.User.create(users.user)