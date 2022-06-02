// alphabets: A-Z
let alphabets =
  Belt.Array.range(65, 26 + 64)
  -> Js.Array2.map(c => c -> Char.chr -> Char.escaped)

let playButton = (message, initGame) => {
    <>
      <button onClick={initGame}>{message -> React.string}</button>
    </>
}

let alphabetInputButtons = (onClickAlpha) => {
  <div onClick={%raw(`o => e => o(e.target.id)`)(onClickAlpha)}>
    {
      {alphabets -> Js.Array2.map(alpha => <button id={alpha}>{alpha -> React.string}</button>)}
      -> React.array
    }
  </div>
}

let wrongGuesses = (word, guesses) => {
  let filterForWrongGuess = (guess) => {
    Js.String.indexOf(guess, word) == -1
  }

  guesses
  -> Belt.Set.String.toArray
  -> Js.Array2.filter(filterForWrongGuess)
  -> Js.Array2.joinWith(", ")
}

let showWrongGuesses = (word, guesses) => {
  <>
    <h3> {("Wrong Guesses: " ++ (wrongGuesses(word, guesses))) -> React.string} </h3>
  </>
}

@react.component
let make = () => {
  let (game, setGameState) = React.useState(_ => GameState.Start)
  let initPlayGame = _ => setGameState(GameState.updateGameState(GameEvents.Init))

  switch game {
    |GameState.Start => playButton("Play", initPlayGame)
    |GameState.Won({word: word}) =>
      <>
        <div> {"You Won!" -> React.string} </div>
        <div> {("The word was " ++ word) -> React.string} </div>
        {playButton("Play Again", initPlayGame)}
      </>
    |GameState.Hanged({word: word}) =>
      <>
        <div> {"You Were Hanged!" -> React.string} </div>
        <div> {("The word was " ++ word) -> React.string} </div>
        {playButton("Play Again", initPlayGame)}
      </>
    |GameState.Play({word: word, guesses: guesses, movesLeft: movesLeft}) =>
      <>
        <h3> {GameState.hideCharacters(word, guesses) -> React.string} </h3>
        <h3> {("Moved Left: " ++ (Js.Int.toString(movesLeft))) -> React.string} </h3>
        {alphabetInputButtons(alpha => _ => setGameState(GameState.updateGameState(GameEvents.Guess(alpha))))}
        {showWrongGuesses(word, guesses)}
      </>
  }
}
