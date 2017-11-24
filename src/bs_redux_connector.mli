(* Type of store *)
type ('a, 'b) t

val create: ('a, 'b) Bs_redux_reducer.t -> 'b -> ('a, 'b) t
(** Create the store via reducer *)

val provider : ('a, 'b) t -> ReasonReact.reactElement array -> ReasonReact.reactElement
(* FFI for Provider component. *)

type 'action dispatch = ('action -> unit [@bs])

val connect :
  ('a -> 'b [@bs]) Js.null ->
  ('c dispatch -> 'd -> 'e [@bs]) Js.null ->
  ('b, 'd, unit) ReasonReact.component ->
  ('b, 'e, unit) ReasonReact.component
(* connect provider to component that send state and dispatch transparently. *)
