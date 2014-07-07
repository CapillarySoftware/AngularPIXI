# data Route = Route Url TemplateKey
class Route
  ({@url, @template}) ->
  fmap : (f) ->  new Route url : (f @url), template : @template

__registry        = {}

# registerRoutes :: [Route] -> IO () 
registerRoutes    = map ({url, template}) -> __registry[url] := template
  
# PresentableRouter :: IO () -> Goodies
PresentableRouter = (_) -> {Route, registerRoutes}

# compileFromTemplate :: PresentableCompiler -> Path -> IO ()
compileFromTemplate = (PC, p) !--> if __registry[p]
                                   then PC p
                                   else PC!

# Main :: $rootScope -> $location -> $templateCache -> PresentableCompiler -> IO ()
Main = ($rs, $l, $tc, PC) !->
  c = compileFromTemplate PC << $l.path  
  $rs.$on '$locationChangeSuccess', c
  c!

angular.module \Present .provider \PresentableRouter, $get : 
  <[$rootScope $location $templateCache PresentableCompiler]> ++ Main >> PresentableRouter

@___PresentableRouterTesting = -> {__registry}