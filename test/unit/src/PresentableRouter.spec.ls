describe "Presentable Router", (,) !->
  Route               = null
  registerRoutes      = null
  $location           = null
  __registry          = null
  PresentableCompiler = null

  beforeEach module "Present"
  beforeEach module ($provide) !->    
    $provide.value "PresentableCompiler",
                    PresentableCompiler := sinon.spy()

  beforeEach inject ($injector, _$location_) !->
    {
      Route
      registerRoutes
    }         := $injector.get 'PresentableRouter' 
    $location := _$location_

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

  describe 'location is heard', (,) !->
    
    it 'compiler should always be called atleast once', !->
      expect PresentableCompiler .to.have.been.calledOnce
