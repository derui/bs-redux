type ('a, 'b) t = {
  redux: 'b -> 'a -> 'b;
  to_json: 'b -> Js.Json.t;
}

let make redux to_json = {redux; to_json}

let apply {redux} state action = redux state action

let to_json {to_json} state = to_json state
