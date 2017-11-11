
module Value = struct
  let int redux = Bs_redux_reducer.make redux (fun v -> Js.Json.number @@ float_of_int v)
  let float redux = Bs_redux_reducer.make redux Js.Json.number
  let string redux = Bs_redux_reducer.make redux Js.Json.string
  let bool redux = Bs_redux_reducer.make redux (fun v -> Js.Boolean.to_js_boolean v |> Js.Json.boolean)
  let json redux = Bs_redux_reducer.make redux (fun x -> x)
end

type ('a, 'b) t = {
    redux: 'b -> 'a -> 'b;
    to_dict: 'b -> Js.Json.t Js.Dict.t;
    value: 'b;
  }

let empty = {
    redux = (fun () _ -> ());
    to_dict = (fun _ -> Js.Dict.empty ());
    value = ();
  }

let field key reducer {redux;to_dict;value} =
  let redux' (x, y) action =
    (Bs_redux_reducer.apply reducer x action, redux y action) in
  let to_dict' (x, y) =
    let dict = to_dict y in
    let () = Js.Dict.set dict key (Bs_redux_reducer.jsonify reducer x) in
    dict
  in
  let value = (None, value) in
  {redux = redux';to_dict = to_dict'; value}

let reducer {redux;to_dict;} =
  let jsonify state = Js.Json.object_ @@ to_dict state in
  Bs_redux_reducer.make redux jsonify

let compose f =
  let {value} as obj = f empty in
  (reducer obj, value)
