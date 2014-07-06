class Route
  ({@url, @template}) ->

__routes   = {}

registerRoute = ({url, template}) -> routes[url] = template

Main = ($rootScope, $location) ->



angular.module \Present .provider \Presentable, {Route, registerRoute, $get : Main}