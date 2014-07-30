# For more information see: http://emberjs.com/guides/routing/

OpenTracker.Router.map () ->
  @resource 'users', ->
    @resource 'user', path: '/:user_id', ->
      @route 'edit', path: '/edit'
  # @resource('posts')

