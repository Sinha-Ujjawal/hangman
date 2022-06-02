// Start -> Play -> Hanged -> Play
// Start -> Play -> Won -> Play

// Start, Hanged, Won
// Play { word: string, lettersCorrectlyPredicted: Set[String] }

type gameState =
  | Start
  | Play({
      word: string,
      guesses: Belt.Set.String.t,
      movesLeft: int,
    })
  | Won({word: string})
  | Hanged({word: string})

let initPlayGame = () => {
  Play({
    word: RandomWordGenerator.getRandomWord() -> Js.String.toUpperCase,
    guesses: Belt.Set.String.empty,
    movesLeft: 7,
  })
}

let hideCharacters = (word: string, guesses: Belt.Set.String.t): string => {
  let mapper = charAsStr => {
    if Belt.Set.String.has(guesses, charAsStr) {
      charAsStr
    } else {
      "*"
    }
  }

  word
  -> Js.String2.split("")
  -> Js.Array2.map(mapper)
  -> Js.String.concatMany("")
}

let guessesCoversTheWord = (word: string, guesses: Belt.Set.String.t): bool => {
  let wordWithHiddenCharacters = hideCharacters(word, guesses)
  wordWithHiddenCharacters == word
}

let guess = (c, state) => {
  switch state {
    |Play(gameData) =>
      let newGuesses = Belt.Set.String.add(gameData.guesses, c)

      if Js.String.indexOf(c, gameData.word) != -1 {
        if guessesCoversTheWord(gameData.word, newGuesses) {
          Won({word: gameData.word})
        } else {
          Play({
            ...gameData,
            guesses: newGuesses,
          })
        }
      } else {
        let state' = Play({
          ...gameData,
          movesLeft: gameData.movesLeft - 1,
          guesses: newGuesses,
        })
        if gameData.movesLeft == 1 {
          Hanged({word: gameData.word})
        } else {
          state'
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
