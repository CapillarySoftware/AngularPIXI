describe "Presentable Compiler", (,) !->
  PresentableCompiler = null
  $templateCache      = null 
  $rootScope          = null

  beforeEach module "Present"

  beforeEach inject ($injector, _$templateCache_, _$rootScope_) !->
    PresentableCompiler := $injector.get 'PresentableCompiler' 
    $templateCache      := _$templateCache_
    $rootScope          := _$rootScope_
