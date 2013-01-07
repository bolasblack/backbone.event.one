describe "the backbone.event.one plugin", ->
  should = chai.should()

  beforeEach ->
    @event1Spy = sinon.spy()
    @event23Spy = sinon.spy()
    @event4Spy = sinon.spy()
    @event5Spy = sinon.spy()
    @filterSpy = sinon.spy()
    @context = {}
    @filterReturnValue = true
    @obj = _.extend {}, Backbone.Events

    _this = this
    @obj.one "test1", @event1Spy, @context, ->
      _this.filterSpy.apply this, arguments
      _this.filterReturnValue

    @obj.one "test2 test3", @event23Spy, @context
    @obj.one {"test4": @event4Spy, "test5": @event5Spy}, @context

  describe "the one method", ->
    it "should be able to be extend", ->
      Backbone.Events.one.should.be.a "Function"

      backboneObjNames = ["Model", "Collection", "View", "Router", "History"]
      for objName in backboneObjNames
        (new Backbone[objName])["one"].should.be.a "Function"

      _.extend({}, Backbone.Events)["one"].should.be.a "Function"

    it "should be work", ->
      @obj.trigger "test1"
      @obj.trigger "test1"
      @event1Spy.calledOnce.should.be.true

    it "should work with jQuery event bind syntax", ->
      @obj.trigger "test2"
      @event23Spy.calledOnce.should.be.true
      @obj.trigger "test3"
      @event23Spy.calledTwice.should.be.true

    it "should work with event map syntax", ->
      @obj.trigger "test4"
      @event4Spy.calledOnce.should.be.true
      @obj.trigger "test5"
      @event5Spy.calledOnce.should.be.true

  describe "the whenFilter", ->
    it "should be called", ->
      @obj.trigger "test1"
      @filterSpy.calledOnce.should.be.true

    it "should called on context", ->
      @obj.trigger "test1"
      @filterSpy.calledOn(@context).should.be.true

    it "should get arguments passed in", ->
      @obj.trigger "test1", "some", "args"
      @filterSpy.withArgs("some", "args").calledOnce.should.be.true

    it "should ignore event if return false", ->
      @filterReturnValue = false
      @obj.trigger "test1"
      @event1Spy.called.should.be.false

    it "should ignore event if return false like value", ->
      @filterReturnValue = ""
      @obj.trigger "test1"
      @event1Spy.called.should.be.false

  describe "the handler argument", ->
    it "should be work", ->
      @obj.trigger "test1", "some", "args"
      @event1Spy.withArgs("some", "args").calledOnce.should.be.true

    it "should called on context", ->
      @obj.trigger "test1"
      @event1Spy.calledOn(@context).should.be.true

    it "should get arguments passed in", ->
      @obj.trigger "test1", "some", "args"
      @event1Spy.withArgs("some", "args").calledOnce.should.be.true
