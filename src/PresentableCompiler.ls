
# Main :: $rootScope -> $templateCache -> IO ()
Main = ($rs, $tc) ->
console.log jsyaml.load "greeting: hello\nname: world"

angular.module \Present .provider \PresentableCompiler, $get :
  <[$rootScope $templateCache]> ++ Main