type ('a, 'b) t = {
    redux: 'b -> 'a -> 'b;
    jsonify: 'b -> Js.Json.t;
  }

let make redux jsonify = {redux; jsonify}

let apply {redux} state action = redux state action

let jsonify {jsonify} state = jsonify state
