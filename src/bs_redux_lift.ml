
let option default reducer =
  let module R = Bs_redux_reducer in

  let redux state action =
    match state with
    | None -> Some(R.apply reducer default action)
    | Some x -> Some(R.apply reducer x action)
  in
  let to_json = function
    | None -> R.to_json reducer default
    | Some x -> R.to_json reducer x
  in

  R.make redux to_json

