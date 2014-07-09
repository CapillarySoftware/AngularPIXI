describe "Presentable Router", (,) !->
  Route               = null
  registerRoutes      = null
  activateRoutes      = null
  $location           = null
  $rootScope          = null
  __registry          = null
  PresentableCompiler = null

  beforeEach module "Present"
  beforeEach module ($provide) !->    
    $provide.value "PresentableCompiler",
                    PresentableCompiler := sinon.spy()

  beforeEach inject ($injector, _$location_, _$rootScope_) !->
    {
      Route
      registerRoutes
      activateRoutes
    }          := $injector.get 'PresentableRouter' 
    $location  := _$location_
    $rootScope := _$rootScope_

  beforeEach !->
    {__registry} := ___PresentableRouterTesting!

  it 'Route should be a simple constructor', !->
    expect Route .to.exist
    r = new Route url : '/foo', template : 'bar'
    expect r .to.be.ok
    expect r.url      .to.equal '/foo'
    expect r.template .to.equal 'bar'

  describe 'route registry', (,) !->
    url      = '/foo'
    template = 'bar'

    it 'registry should start empty', !->
      expect __registry .to.be.empty

    it 'registerRoutes should add', !->
      registerRoutes [new Route {url, template}]
      expect __registry      .to.not.be.empty
      expect __registry      .to.have.property url
      expect __registry[url] .to.equal template

    it 'a non route should error', !->
      bad = ->
        registerRoutes [{url, template}]

      expect bad .to.throw Error

  describe 'location is heard', (,) !->

    describe 'with no routes', (,) !->

      beforeEach -> activateRoutes!
    
      it 'compiler should always be called atleast once', !->
        expect PresentableCompiler .to.have.been.calledOnce

    describe 'with routes', (,) !->

      beforeEach !->
        registerRoutes [
          new Route url : '/foo', template : 'first'
          new Route url : '/bar', template : 'second'
          new Route url : '/baz', template : 'third'
        ]
        activateRoutes!

      locateAndDigest = (p) !->
        $location.path p
        $rootScope.$digest!

      it 'the head of the routes should be the default', !->
        expect PresentableCompiler .to.have.been.calledWith 'first'
        expect $location.path! .to.equal '/foo'

      it 'the location should allow the first redudantly', !->
        locateAndDigest '/foo'
        expect PresentableCompiler .to.have.been.calledWith 'first'

      it 'the location should control the template', !->
        locateAndDigest '/bar'
        expect PresentableCompiler .to.have.been.calledWith 'second'
        locateAndDigest '/baz'
        expect PresentableCompiler .to.have.been.calledWith 'third'


