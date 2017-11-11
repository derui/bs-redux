open Bs_testing

type action = [`Inc | `Dec]
let counter () = 
  let module C = Bs_redux.Composer in 
  let redux state = function
    | `Inc -> state + 1
    | `Dec -> state - 1
  in
  C.Value.int redux |> Bs_redux.Lift.option 0

let reverse_counter () = 
  let module C = Bs_redux.Composer in 
  let redux state = function
    | `Inc -> state - 1
    | `Dec -> state + 1
  in
  C.Value.int redux |> Bs_redux.Lift.option 0

let _ =
  suite "bs-redux reducer composer" [
          Sync ("can compose reducer as object", fun () ->
                                                  let reducer, value = Bs_redux.Composer.compose (fun t ->
                                                                let module C = Bs_redux.Composer in 
                                                                t
                                                                |> C.field "value" (counter ())
                                                              ) in
                                                  let obj = Js.Json.parseExn {| {"value": -1} |} in
                                                  assert_eq obj Bs_redux.Reducer.(apply reducer value `Dec |> jsonify reducer));
          Sync ("can compose reducers as object", fun () ->
                                                  let reducer, value = Bs_redux.Composer.compose (fun t ->
                                                                let module C = Bs_redux.Composer in 
                                                                t
                                                                |> C.field "counter" (counter ())
                                                                |> C.field "reverseCounter" (reverse_counter ())
                                                              ) in
                                                  let obj = Js.Json.parseExn {| {"counter": -1, "reverseCounter": 1} |} in
                                                  assert_eq obj Bs_redux.Reducer.(apply reducer value `Dec |> jsonify reducer));
          Sync ("can compose reducer to be composed", fun () ->
                                                      let c1, v1 = Bs_redux.Composer.(compose @@ fun t -> t |> field "value" @@ counter ()) in 
                                                      let c2, v2 = Bs_redux.Composer.(compose @@ fun t -> t |> field "value" @@ reverse_counter ()) in 
                                                  let reducer, value = Bs_redux.Composer.compose (fun t ->
                                                                let module C = Bs_redux.Composer in 
                                                                t
                                                                |> C.field "counter" (Bs_redux.Lift.option v1 c1)
                                                                |> C.field "reverseCounter" (Bs_redux.Lift.option v2 c2)
                                                              ) in
                                                  let obj = Js.Json.parseExn {| {"counter": {"value" : -1}, "reverseCounter": {"value": 1}} |} in
                                                  assert_eq obj Bs_redux.Reducer.(apply reducer value `Dec |> jsonify reducer));
  ];
