
let partial lifter reducer =
  let module R = Bs_rillet_reducer in
  let redux action state = lifter state (R.apply reducer action) in
  R.make redux

let combine reducers =
  let module R = Bs_rillet_reducer in
  let redux action state =
    let rec reduce reducers state =
      match reducers with
      | [] -> state
      | r :: rest -> reduce rest (R.apply r action state)
    in
    reduce (Array.to_list reducers) state
  in
  R.make redux
