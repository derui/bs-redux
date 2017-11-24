(* Type of store *)
type ('a, 'b) t

val create: ('a, 'b) Bs_redux_reducer.t -> 'b -> ('a, 'b) t
(** Create the store via reducer *)

val provider : ('a, 'b) t -> ReasonReact.reactElement array -> ReasonReact.reactElement
(* FFI for Provider component. *)

type 'action dispatch = ('action -> unit [@bs])

val connect :
  map_state:('c Js.t -> 'b) ->
  component:('b, 'd, unit) ReasonReact.component ->
  ('a, 'b) t ->
  ('b, 'd, unit) ReasonReact.component
(* connect provider to component that send state and dispatch transparently. *)
