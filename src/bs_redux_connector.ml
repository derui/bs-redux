(* Define FFI for store, but not defined FFI to operate directly store.
   Should use connect function and provider to use with React
*)
[%%bs.raw{|
const React = require('react');
const Provider = require('react-redux').Provider;
const connect = require('react-redux').connect;

function createProvider(store, children) {
  return React.createElement(Provider, {store: store}, children);
}

function _wrappedConnect(mapStateToProp, component) {
  return connect(mapStateToProp)(component);
}
|}]
(* Use helper function instead of reason-react's createElement function. *)

type ('a, 'b) store
type ('a, 'b) t = {
    store: ('a, 'b) store;
    to_json: 'b -> Js.Json.t;
  }

external createStore : ('b -> 'a -> 'b [@bs]) -> 'b -> ('a, 'b) store = "" [@@bs.module "redux"]
(* Create store with reducer and initial state *)

external to_state: 'a -> 'b = "%identity"

let create reducer state =
  let module R = Bs_redux_reducer in 
  let reducer' = fun [@bs] state action -> R.apply reducer state action in
  let store = createStore reducer' (to_state state) in
  let to_json = R.to_json reducer in
  {store; to_json}

external _createProvider: ('a, 'b) t -> ReasonReact.reactElement array -> ReasonReact.reactElement = "createProvider" [@@bs.val]

(** Create the provider element. *)
let provider store children = _createProvider store children

type 'action dispatch = ('action -> unit [@bs])

(* Connect dispatch to prop and re-initialize state.
   Use function defined in raw to avoid issue for arity of function
*)
external _connect: ('a -> 'b [@bs]) ->
  ('b, 'prop, unit) ReasonReact.component ->
  ('b, 'newprop, unit) ReasonReact.component = "_wrappedConnect" [@@bs.val]

let connect ~map_state ~component t =
  (* convert type of json to JS object forcely.
     Reducers only apply JSON value specified in JSON spec, so
     will happen undefined behavior if map_state's type contains function or any other value
     that are not specified in JSON spec.
   *)
  let mapper = fun [@bs] v -> map_state @@ Obj.magic @@ t.to_json v in
  _connect mapper component

