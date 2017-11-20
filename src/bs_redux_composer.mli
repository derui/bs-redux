(** The module contains helper functions to create reducer as JSON-defined value. *)
module Value :
sig
  val int : (int -> 'a -> int) -> ('a, int) Bs_redux_reducer.t
  val float : (float -> 'a -> float) -> ('a, float) Bs_redux_reducer.t
  val string : (string -> 'a -> string) -> ('a, string) Bs_redux_reducer.t
  val bool : (bool -> 'a -> bool) -> ('a, bool) Bs_redux_reducer.t
  val json : (Js.Json.t -> 'a -> Js.Json.t) -> ('a, Js.Json.t) Bs_redux_reducer.t
end

type ('a, 'b) t
(** The type of composer *)

val field : Js.Dict.key -> ('a, 'b option) Bs_redux_reducer.t -> ('a, 'c) t -> ('a, 'b option * 'c) t
(** Add field with key to composed object. *)

val compose : (('a, unit) t -> ('b, 'c) t) -> ('b, 'c) Bs_redux_reducer.t * 'c
(** Build composer with function *)
