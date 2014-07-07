class Route
  ({@url, @template}) ->
  fmap : (f) ->  new Route url : (f @url), template : @template

__registry        = {}

map = (f, x) -> Array.prototype.map.call x, f

# registerRoutes :: [Route] -> IO () 
registerRoutes     = (rs) !->
  map (({url, template}) -> __registry[url] := template), rs
  
# PresentableRouter :: IO () -> Goodies
PresentableRouter = (_) -> {Route, registerRoutes}

# Main :: $rootScope -> $location -> $templateCache -> PresentableCompiler -> IO ()
Main = ($rs, $l, $tc, PC) !->
  
  # compileFromTemplate :: Path -> IO ()
  compileFromTemplate = (p) !->
    if __registry[p]
    then PC p
    else PC!

  c = compileFromTemplate . $l.path  
  $rs.$on '$locationChangeSuccess', c
  c!

angular.module \Present .provider \PresentableRouter, $get : 
  <[$rootScope $location $templateCache PresentableCompiler]> ++ PresentableRouter . Main

@___PresentableRouterTesting = -> {__registry}