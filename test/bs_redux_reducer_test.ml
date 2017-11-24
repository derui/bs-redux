open Bs_testing

type action = [`Inc | `Dec]
let reducer = 
  let redux state = function
    | `Inc -> state +. 1.0
    | `Dec -> state -. 1.0
  in
  let to_json = Js.Json.number in
  Bs_redux.Reducer.make redux to_json

let _ =
  suite "bs-redux reducer" [
    Sync ("can apply reduce function to state with Dec event", fun () -> assert_eq 0.0 (Bs_redux.Reducer.apply reducer 1.0 `Dec));
    Sync ("can apply reduce function to state with Inc event", fun () -> assert_eq 2.0 (Bs_redux.Reducer.apply reducer 1.0 `Inc));
    Sync ("can convert value to json", fun () -> let v = Js.Json.number 1.0 in assert_eq v (Bs_redux.Reducer.to_json reducer 1.0));
  ];
