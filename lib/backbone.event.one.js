// Generated by CoffeeScript 1.3.3
(function() {

  (function(_, Backbone) {
    var objName, one, _i, _len, _ref;
    if (Backbone == null) {
      return;
    }
    one = function(events, handler, context, whenFilter) {
      var fn,
        _this = this;
      if (_.isFunction(context)) {
        whenFilter = context;
        context = this;
      }
      if (context == null) {
        context = this;
      }
      if (whenFilter == null) {
        whenFilter = function() {
          return true;
        };
      }
      fn = function() {
        if (!whenFilter.apply(context, arguments)) {
          return;
        }
        _this.off(events, fn, context);
        return handler.apply(context, arguments);
      };
      return this.on(events, fn, context);
    };
    if (Backbone.Events.one != null) {
      return;
    }
    Backbone.Events.one = one;
    _ref = ["Model", "Collection", "View", "Router", "History"];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      objName = _ref[_i];
      if (Backbone[objName].prototype.one != null) {
        return;
      }
      _.extend(Backbone[objName].prototype, Backbone.Events);
    }
  })(_, Backbone);

}).call(this);