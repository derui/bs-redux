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

function _wrappedConnect(mapStateToProp, mapDispatchToProp, component) {
  return connect(mapStateToProp, mapDispatchToProp)(component);
}
|}]
(* Use helper function instead of reason-react's createElement function. *)

type ('a, 'b) t

external createStore : ('b -> 'a -> 'b [@bs]) -> 'b -> ('a, 'b) t = "" [@@bs.module "redux"]
(* Create store with reducer and initial state *)

let create reducer state =
  let reducer' = fun [@bs] state action -> Bs_redux_reducer.apply reducer state action in
  createStore reducer' state

external _createProvider: ('a, 'b) t -> ReasonReact.reactElement array -> ReasonReact.reactElement = "createProvider" [@@bs.val]

(** Create the provider element. *)
let provider store children = _createProvider store children

type 'action dispatch = ('action -> unit [@bs])

(* Connect dispatch to prop and re-initialize state.
   Use function defined in raw to avoid issue for arity of function
*)
external _connect: ('a -> 'b [@bs]) Js.null -> ('action dispatch -> 'prop -> 'newprop [@bs]) Js.null ->
  ('b, 'prop, unit) ReasonReact.component ->
  ('b, 'newprop, unit) ReasonReact.component = "_wrappedConnect" [@@bs.val]

let connect map_state map_dispatch component = _connect map_state map_dispatch component
