# Backbone.event.one

**Add `one` method to `Backbone.Events`**

## Install

```html
<script src="../lib/jquery-1.8.2.min.js" type="text/javascript"></script>
<script src="../lib/underscore-min.js" type="text/javascript"></script>
<script src="../lib/backbone-min.js" type="text/javascript"></script>
<script src="../lib/backbone.event.one.js" type="text/javascript"></script>
```

## Usage

```coffeescript
eventSpy = sinon.spy()

obj = _.extend {}, Backbone.Events
obj.one "test", eventSpy, context, ->
  _this.filterSpy.apply this, arguments
  _this.filterReturnValue

obj.trigger "test"
obj.trigger "test"
eventSpy.calledOnce.should.be.true
```
