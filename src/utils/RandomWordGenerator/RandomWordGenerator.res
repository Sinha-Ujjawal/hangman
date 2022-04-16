let getRandomValue = arr => {
  let i = Js.Math.random_int(0, Js.Array2.length(arr) - 1)
  arr[i]
}

let getRandomWord = () => getRandomValue(Word.words)
