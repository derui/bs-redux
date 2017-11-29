type ('a, 'b) t = {
  redux: 'b -> 'a -> 'a;
}

let make redux = {redux}

let apply {redux} action state = redux action state
