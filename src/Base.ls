
@ <<< require 'prelude-ls'
@fmap  = (f, a) -> a.fmap f

@check  = (sub, obj) -->
  if (sub.displayName && sub.displayName == obj.constructor.displayName) 
  then obj
  else throw new Error "#obj is not of type #sub"

angular.module 'Present', []
