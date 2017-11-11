
let option default reducer =
  let module R = Bs_redux_reducer in

  let redux state action =
    match state with
    | None -> Some(R.apply reducer default action)
    | Some x -> Some(R.apply reducer x action)
  in
  let jsonify = function
    | None -> R.jsonify reducer default
    | Some x -> R.jsonify reducer x
  in

  R.make redux jsonify

