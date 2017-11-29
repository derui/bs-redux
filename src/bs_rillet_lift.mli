
val partial: ('c -> ('b -> 'b) -> 'c) -> ('b, 'a) Bs_rillet_reducer.t -> ('c, 'a) Bs_rillet_reducer.t
(** Lift reducer to apply partial state with extractor function *)

val combine : ('state, 'action) Bs_rillet_reducer.t array -> ('state, 'action) Bs_rillet_reducer.t
                                                                               (** Combine reducers to one reducer *)
