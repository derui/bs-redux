(* Type of store *)
type 'a t

external createStore : ('a, 'b) Bs_redux_reducer.t -> 'b -> 'b t = "" [@@bs.module "redux"]
(* FFI for redux's createStore *)

external getState : 'a t -> 'a = "" [@@bs.get]
(* FFI for store API to get state *)

val provider : 'a t -> ReasonReact.reactElement array -> ReasonReact.reactElement
(* FFI for Provider component *)

type 'action dispatch = ('action -> unit [@bs])

val connect :
  ('a -> 'b [@bs]) Js.null ->
  ('c dispatch -> 'd -> 'e [@bs]) Js.null ->
  ('b, 'd, unit) ReasonReact.component ->
  ('b, 'e, unit) ReasonReact.component

(* FFI for connect API to connect provider and some component *)
