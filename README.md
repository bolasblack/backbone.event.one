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
filterSpy = sinon.spy()

obj = _.extend {}, Backbone.Events
obj.one "test", eventSpy, context, (returnValue) ->
  filterSpy.apply this, arguments
  returnValue

obj.trigger "test", false
filterSpy.called.should.be.true
eventSpy.called.should.be.false

obj.trigger "test", true
filterSpy.calledTwice.should.be.true
eventSpy.calledOnce.should.be.true
```
