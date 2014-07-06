class Route
  ({@url, @template}) ->
  fmap : (f) -> f @url

__registry   = {}

registerRoute = ({url, template}) -> routes[url] = template

PresentableRouter = ($rootScope) -> {Route, registerRoute}

Main = ($rootScope, $location) ->

  $rootScope.$on '$locationChangeSuccess', ->
    
  PresentableRouter!

angular.module \Present .provider \PresentableRouter, $get : Main

@___PresentableRouterTesting = -> {__registry}