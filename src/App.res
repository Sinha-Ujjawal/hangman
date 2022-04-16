@react.component
let make = () => {
  let randomWord = RandomWordGenerator.getRandomWord()
  <>
    <h1> {"Hangman" -> React.string} </h1>
    <Counter />
    <h3> {randomWord -> React.string} </h3>
  </>
}
