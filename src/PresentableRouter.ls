class Route
  ({@url, @template}) ->

__routes   = {}

registerRoute = ({url, template}) -> routes[url] = template

Main = ($rootScope, $location) ->



angular.module \Present .provider \PresentableRouter, {Route, registerRoute, $get : Main}