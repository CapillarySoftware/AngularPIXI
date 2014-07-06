describe "Presentable Router", (,) ->
  Route         = null
  registerRoute = null
  $location     = null
  __registry    = null

  beforeEach module "Present"
  beforeEach inject ($injector, _$location_) !->
    {
      Route
      registerRoute
    }         := $injector.get 'PresentableRouter' 
    $location := _$location_

  beforeEach !->
    {__registry} = ___PresentableRouterTesting!

  it 'Route should be a simple constructor', ->
    expect Route .to.exist
    r = new Route url : '/foo', template : 'bar'
    expect r .to.be.ok
    expect r.url      .to.equal '/foo'
    expect r.template .to.equal 'bar'

  describe 'route registry', (,) ->
    it 'registry should start empty', ->
      expect __registry .to.be.empty

    it 'registerRoute should add', ->
