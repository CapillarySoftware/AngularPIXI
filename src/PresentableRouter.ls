# data Route = Route Url TemplateKey
class Route
  ({@url, @template}) ->
  fmap : (f) ->  new Route url : (f @url), template : @template

__registry          = {}

# registerRoutes :: Route -> IO ()
_registerRoutes = map ({url, template}) !-> __registry[url] := template

# registerRoutes :: [Route] -> IO () 
registerRoutes    = (rs) !-> 
  __registry.__default = head rs
  _registerRoutes rs

# runTemplate :: PresentableCompiler -> $location -> Route -> IO ()
runTemplate = (PC, $l, {url, template}) !-> 
   $l.path url if $l.path! !== url
   PC template

# route :: PresentableCompiler -> $location -> URL -> IO ()
route = (PC, $l) !-> 
  | __registry[$l.path!] => PC __registry[$l.path!]
  | __registry.__default => runTemplate PC, $l, __registry.__default
  | otherwise            => runTemplate PC, $l, new Route url : "/", template : ""

# Main :: PresentableCompiler -> $rootScope -> $location -> $templateCache -> IO ActivateRoutes
Main = (PC, $rs, $l, $tc) ->  
  $rs.$on '$locationChangeSuccess', !-> route PC, $l
  return -> $rs.$emit '$locationChangeSuccess'

angular.module \Present .provider \PresentableRouter, $get : 
  <[PresentableCompiler $rootScope $location $templateCache]> ++ Main >> (activateRoutes) -> { Route, registerRoutes, activateRoutes }

@___PresentableRouterTesting = -> {__registry}