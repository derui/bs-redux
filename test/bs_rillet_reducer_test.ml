open Bs_testing

type action = [`Inc | `Dec]
let reducer = 
  let redux action state =
    match action with
    | `Inc -> state +. 1.0
    | `Dec -> state -. 1.0
  in
  Bs_rillet.Reducer.make redux

let _ =
  suite "bs-rillet reducer" [
    Sync ("can apply reduce function to state with Dec event", fun () -> assert_eq 0.0 (Bs_rillet.Reducer.apply reducer `Dec 1.0));
    Sync ("can apply reduce function to state with Inc event", fun () -> assert_eq 2.0 (Bs_rillet.Reducer.apply reducer `Inc 1.0));
  ];
