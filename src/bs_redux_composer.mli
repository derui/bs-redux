module Value :
  sig
    val int : (int -> 'a -> int) -> ('a, int) Bs_redux_reducer.t
    val float : (float -> 'a -> float) -> ('a, float) Bs_redux_reducer.t
    val string : (string -> 'a -> string) -> ('a, string) Bs_redux_reducer.t
    val bool : (bool -> 'a -> bool) -> ('a, bool) Bs_redux_reducer.t
    val json :
      (Js.Json.t -> 'a -> Js.Json.t) -> ('a, Js.Json.t) Bs_redux_reducer.t
  end
type ('a, 'b) t

val field : Js.Dict.key -> ('a, 'b option) Bs_redux_reducer.t -> ('a, 'c) t -> ('a, 'b option * 'c) t
val reducer : ('a, 'b) t -> ('a, 'b) Bs_redux_reducer.t
val compose : (('a, unit) t -> ('b, 'c) t) -> ('b, 'c) Bs_redux_reducer.t * 'c
