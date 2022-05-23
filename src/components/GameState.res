// Start -> Play -> Hanged -> Play
// Start -> Play -> Won -> Play

// Start, Hanged, Won
// Play { word: string, lettersCorrectlyPredicted: Set[String] }

type gameState =
  | Start
  | Play({
      word: string,
      lettersCorrectlyPredicted: Belt.Set.String.t,
      movesLeft: int,
      numberOfCharsToFind: int,
    })
  | Won({word: string})
  | Hanged({word: string})

let initPlayGame = () => {
  let word = RandomWordGenerator.getRandomWord() -> Js.String.toUpperCase
  let n =
    word
    -> Js.String2.split("")
    -> Belt.Set.String.fromArray
    -> Belt.Set.String.size
 
  Play({
    word: word,
    lettersCorrectlyPredicted: Belt.Set.String.empty,
    movesLeft: 7,
    numberOfCharsToFind: n
  })
}

let guess = (c, state) => {
  switch state {
    |Play(gameData) =>
      if (Belt.Set.String.has(gameData.lettersCorrectlyPredicted, c)) {
        state
      } else {
        if Js.String.indexOf(c, gameData.word) != -1 {
          let state' = Play({
            ...gameData,
            lettersCorrectlyPredicted: Belt.Set.String.add(gameData.lettersCorrectlyPredicted, c),
            numberOfCharsToFind: gameData.numberOfCharsToFind - 1,
          })
          if gameData.numberOfCharsToFind == 1 {
            Won({word: gameData.word})
          } else {
            state'
          }
        } else {
          let state' = Play({
            ...gameData,
            movesLeft: gameData.movesLeft - 1
          })
          if gameData.movesLeft == 1 {
            Hanged({word: gameData.word})
          } else {
            state'
          }
        }
      }
    |_ => state
  }
}

let updateGameState = (event: GameEvents.gameEvent, state: gameState) => {
  switch event {
    | GameEvents.Init => initPlayGame()
    | GameEvents.Guess(c) => guess(c, state)
  }
}
