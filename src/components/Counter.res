let incr = (prev) => prev + 1
let decr = (prev) => prev - 1

@react.component
let make = () => {
    let (count, setCount) = React.useState (_ => 0)
    let countStr = "Count: " ++ (count -> Belt.Int.toString)
    <>
        <h2>{"Counter" -> React.string}</h2>
        <h3>{countStr -> React.string}</h3>
        <div>
            <button onClick={_ => setCount (incr)}>
                {"+" -> React.string}
            </button>
        </div>
        <div>
            <button onClick={_ => setCount (decr)}>
                {"-" -> React.string}
            </button>
        </div>
    </>
}
