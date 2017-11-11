type ('a, 'b) t

val make : ('a -> 'b -> 'a) -> ('a -> Js.Json.t) -> ('b, 'a) t
(** Make reducer with conversion function and jsonify function *)

val apply : ('a, 'b) t -> 'b -> 'a -> 'b
(** apply reducer with state and action *)

val jsonify : ('a, 'b) t -> 'b -> Js.Json.t
                                    (** Convert state to json using with reducer's jsonify *)

