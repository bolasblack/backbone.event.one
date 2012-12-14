describe "the backbone.event.one plugin", ->
  should = chai.should()

  beforeEach ->
    @eventSpy = sinon.spy()
    @filterSpy = sinon.spy()
    @context = {}
    @filterReturnValue = true
    @obj = _.extend {}, Backbone.Events

    _this = this
    @obj.one "test", @eventSpy, @context, ->
      _this.filterSpy.apply this, arguments
      _this.filterReturnValue

  describe "the one method", ->
    it "should be able to be extend", ->
      Backbone.Events.one.should.be.a "Function"

      backboneObjNames = ["Model", "Collection", "View", "Router", "History"]
      for objName in backboneObjNames
        (new Backbone[objName])["one"].should.be.a "Function"

      _.extend({}, Backbone.Events)["one"].should.be.a "Function"

    it "should be work", ->
      @obj.trigger "test"
      @obj.trigger "test"
      @eventSpy.calledOnce.should.be.true

  describe "the whenFilter", ->
    it "should make event ignored if return false", ->
      @filterReturnValue = false
      @obj.trigger "test"
      @eventSpy.called.should.be.false
      @filterSpy.calledOnce.should.be.true

    it "should make event ignored if return false like value", ->
      @filterReturnValue = ""
      @obj.trigger "test"
      @eventSpy.called.should.be.false
      @filterSpy.calledOnce.should.be.true

    it "should be called", ->
      @obj.trigger "test"
      @filterSpy.calledOnce.should.be.true

    it "should called on context", ->
      @obj.trigger "test"
      @filterSpy.calledOn(@context).should.be.true

    it "should get arguments passed in", ->
      @obj.trigger "test", "some", "args"
      @filterSpy.withArgs("some", "args").calledOnce.should.be.true

  describe "the handler argument", ->
    it "should be work", ->
      @obj.trigger "test", "some", "args"
      @eventSpy.withArgs("some", "args").calledOnce.should.be.true

    it "should called on context", ->
      @obj.trigger "test"
      @eventSpy.calledOn(@context).should.be.true

    it "should get arguments passed in", ->
      @obj.trigger "test", "some", "args"
      @eventSpy.withArgs("some", "args").calledOnce.should.be.true
