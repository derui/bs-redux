(* This module provides APIs to combine OCaml and redux as middleware *)
class type ['action] _dispatcher =
  object
    method dispatch: 'action -> unit
  end [@bs]

type 'a dispatcher = 'a _dispatcher Js.t

external applyMiddleware:
  ('action dispatcher -> (('action -> 'state) -> ('action -> 'state [@bs]) [@bs]) [@bs])
  -> (('action, 'state) Bs_redux_reducer.t -> 'state -> ('action, 'state) Bs_redux_connector.t [@bs])
  = "" [@@bs.module "redux"]

