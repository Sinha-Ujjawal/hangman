// alphabets: A-Z
let alphabets =
  Belt.Array.range(65, 26 + 64)
  -> Js.Array2.map(c => c -> Char.chr -> Char.escaped)

let playButton = (message, initGame) => {
    <>
      <button onClick={initGame}>{message -> React.string}</button>
    </>
}

let hideChars = (string, chars) => {
  let mapper = charAsStr => {
    if Belt.Set.String.has(chars, charAsStr) {
      charAsStr
    } else {
      "*"
    }
  }

  string
  -> Js.String2.split("")
  -> Js.Array2.map(mapper)
  -> Js.String.concatMany("")
}

let alphabetInputButtons = (onClickAlpha) => {
  <div onClick={%raw(`o => e => o(e.target.id)`)(onClickAlpha)}>
    {
      {alphabets -> Js.Array2.map(alpha => <button id={alpha}>{alpha -> React.string}</button>)}
      -> React.array
    }
  </div>
}

@react.component
let make = () => {
  let (game, setGameState) = React.useState(_ => GameState.Start)
  let initPlayGame = _ => setGameState(GameState.updateGameState(GameEvents.Init))

  switch game {
    |GameState.Start => playButton("Play", initPlayGame)
    |GameState.Won =>
      <>
        <div> {"You Won!" -> React.string} </div>
        {playButton("Play Again", initPlayGame)}
      </>
    |GameState.Hanged =>
      <>
        <div> {"You Were Hanged!" -> React.string} </div>
        {playButton("Play Again", initPlayGame)}
      </>
    |GameState.Play({word: word, lettersCorrectlyPredicted: lettersCorrectlyPredicted}) =>
      <>
        <h3> {hideChars(word, lettersCorrectlyPredicted) -> React.string} </h3>
        {alphabetInputButtons(alpha => _ => setGameState(GameState.updateGameState(GameEvents.Guess(alpha))))}
      </>
  }
}
