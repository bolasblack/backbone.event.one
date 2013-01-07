do (_, Backbone) ->
  return unless Backbone?

  one = (events, handler, context, whenFilter) ->
    if typeof events is "object"
      for k, v of events
        @one k, v, handler, context, whenFilter
      return this
    else if /\s+/.test events
      for k in events.split /\s+/
        @one k, handler, context, whenFilter
      return this

    if _.isFunction(context)
      whenFilter = context
      context = this

    context ?= this
    whenFilter ?= -> true

    fn = =>
      return unless whenFilter.apply context, arguments
      @off events, fn, context
      handler.apply context, arguments

    @on events, fn, context

  Backbone.Events.one = one
  for objName in ["Model", "Collection", "View", "Router", "History"]
    _.extend Backbone[objName].prototype, Backbone.Events
