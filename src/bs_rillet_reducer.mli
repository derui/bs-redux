type ('state, 'action) t
(** The type of reducer. *)

val make : ('action -> 'state -> 'state) -> ('state, 'action) t
(** Make reducer with conversion function and to_json function *)

val apply : ('state, 'action) t -> 'action -> 'state -> 'state
(** apply reducer with state and action *)

