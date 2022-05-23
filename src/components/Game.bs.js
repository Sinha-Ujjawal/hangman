// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Char from "rescript/lib/es6/char.js";
import * as Curry from "rescript/lib/es6/curry.js";
import * as React from "react";
import * as GameState from "./GameState.bs.js";
import * as Belt_Array from "rescript/lib/es6/belt_Array.js";
import * as Belt_SetString from "rescript/lib/es6/belt_SetString.js";
import * as Caml_splice_call from "rescript/lib/es6/caml_splice_call.js";

var alphabets = Belt_Array.range(65, 90).map(function (c) {
      return Char.escaped(Char.chr(c));
    });

function playButton(message, initGame) {
  return React.createElement(React.Fragment, undefined, React.createElement("button", {
                  onClick: initGame
                }, message));
}

function hideChars(string, chars) {
  var mapper = function (charAsStr) {
    if (Belt_SetString.has(chars, charAsStr)) {
      return charAsStr;
    } else {
      return "*";
    }
  };
  return Caml_splice_call.spliceObjApply("", "concat", [string.split("").map(mapper)]);
}

function alphabetInputButtons(onClickAlpha) {
  return React.createElement("div", {
              onClick: (o => e => o(e.target.id))(onClickAlpha)
            }, alphabets.map(function (alpha) {
                  return React.createElement("button", {
                              id: alpha
                            }, alpha);
                }));
}

function Game(Props) {
  var match = React.useState(function () {
        return /* Start */0;
      });
  var setGameState = match[1];
  var game = match[0];
  var initPlayGame = function (param) {
    return Curry._1(setGameState, (function (param) {
                  return GameState.updateGameState(/* Init */0, param);
                }));
  };
  if (typeof game === "number") {
    return playButton("Play", initPlayGame);
  }
  switch (game.TAG | 0) {
    case /* Play */0 :
        return React.createElement(React.Fragment, undefined, React.createElement("h3", undefined, hideChars(game.word, game.lettersCorrectlyPredicted)), React.createElement("h3", undefined, "Moved Left: " + game.movesLeft.toString()), alphabetInputButtons(function (alpha, param) {
                        var partial_arg = /* Guess */{
                          _0: alpha
                        };
                        return Curry._1(setGameState, (function (param) {
                                      return GameState.updateGameState(partial_arg, param);
                                    }));
                      }));
    case /* Won */1 :
        return React.createElement(React.Fragment, undefined, React.createElement("div", undefined, "You Won!"), React.createElement("div", undefined, "The word was " + game.word), playButton("Play Again", initPlayGame));
    case /* Hanged */2 :
        return React.createElement(React.Fragment, undefined, React.createElement("div", undefined, "You Were Hanged!"), React.createElement("div", undefined, "The word was " + game.word), playButton("Play Again", initPlayGame));
    
  }
}

var make = Game;

export {
  alphabets ,
  playButton ,
  hideChars ,
  alphabetInputButtons ,
  make ,
  
}
/* alphabets Not a pure module */
