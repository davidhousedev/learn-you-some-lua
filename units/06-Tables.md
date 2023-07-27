# Unit 6 - Tables

## Readings

### Your first complex data structure

So far, you've worked with what are called "primitive" data structures, for example strings, numbers, and booleans. Primitive data structures work really well for representing simple data, but if that's all you had to work with, building complex software would get difficult very quickly.

Most programming languages have the same primitive data structures, because hardware represents those data structures very easily. The differences between programming languages are most often found in how they represent _complex_ data structures.

Some languages have many different complex data structures, some have very few. Lua only has one: the Table.

You might think that having only one complex data structure is a limitation of Lua, and some programmers would argue that it is. That said, if you're only going to have one complex data structure available to you, Tables are pretty fantastic.

### Key->Value data

Lua tables implement a data structure called an "associative array". That means that data within a table follows a few patterns:

- Data is ordered. If you add data to a table, then read the contents of the table, you will read the contents in the same order that you added them.
- Values are "keyed" by either by numbers, strings, booleans, or nils. It is also possible to use tables as keys, but this is a _very_ advanced pattern that should be avoided until you have a clear understanding of "by-reference vs by-value" mechanics.

You may also describe tables as a "key-value" data structure. You can find key-value data structures in many other programming languages, here are a few examples:

- Python -> the `dictionary`
- Javascript -> the `object`
- Ruby -> the `hash`
- PHP -> the `associative array`

Each of these key-value data structures behaves slightly differently depending on the language, but they all allow you to store data according to keys.

Did you notice that the Python data structure for key-value data is called a "dictionary"? That's because a dictionary is a book, where definitions are keyed by words.

Here's a simple example of a table in Lua

```lua
local me = {
  firstName = 'Leeroy',
  lastName = 'Jenkins'
}

print(me.firstName)                       -- prints "Leeroy"
print(me.lastName)                        -- prints "Jenkins"
print(me.firstName .. ' ' .. me.lastName) -- prints "Leeroy Jenkins"

print(me["firstName"])                    -- also prints "Leeroy"
print(me["lastName"])                     -- also prints "Jenkins"
```

Let's break down the example above:

- `me` is a variable that references a table that contains two keys
  - `firstName` is a key of the table, whose value is `"Leeroy"`
  - `lastName` is a key of a table, whose value is `"Jenkins"`
- `me.firstName` is the syntax for "look up the value in the `me` table associated with the key of `firstName`"
- `me.lastName` is the syntax for "look up the value in the `me` table associated with the key of `firstName`"
- Note that while "dot notation" (e.g. `me.firstName`) is most frequently used, you may also use "bracket notation" (e.g. `me["firstName"]`). Lua behaves the same way regardless how you write it.

```lua
local dog = {
  name = "Neptune",
  bark = function()
    print("bark! I'm a dog!")
  end
}

print(dog.name) -- prints "Neptune"
dog.bark()      -- prints "bark! I'm a dog!"
```

Now we're cooking! When working in Lua, it's often very useful to "build behavior into" a complex data structure. That way, it can do store data and do stuff!

Here's another example, where a table _contains another table_:

```lua
local me = {
  name = "Spongebob",
  age = -1,
  address = {
    street = "123 Main St",
    city = "New York",
    country = "USA"
  }
}

print(me.address.street) -- Output: 123 Main St
```

### Take a break to practice working with Tables

Tables are a very complex tool to work with if you're unfamiliar. Pause here and give these practice exercises a try before you move onward.

1. Write a table that stores your first name, last name, and your favorite color. Print these values using dot notation.
2. Write a table that stores a list of your favorites and your least favorites. It should store the name of your favorite movie, video game, and music artist. Additionally, it should also store your least favorites of each. Print out all values using bracket notation.

### Tables represent entities in our software

Okay, now this is going to get complex quickly. Are you ready? We're going to introduce the concept of "encapsulation".

```lua
local function makePlayer(name, startingHealth)
  local health = startingHealth   -- store the player's health within this function scope

  local player = {                -- create a player
    takeDamage = function(damage) -- create a way for a player to take damage
      health = health - damage

      if (health < 0) then
        print(name .. " is dead")
      end
    end,
    getCurrentHealth = function() -- create a way to query the player's current health
      if health > 0 then
        return health
      else
        return "Dead"
      end
    end
  }

  return player
end


local playerOne = makePlayer("Spongebob", 5)
playerOne.takeDamage(2)
playerOne.takeDamage(1)
print(playerOne.getCurrentHealth()) -- prints 2
playerOne.takeDamage(3)             -- prints "Spongebob is dead"
```

Some questions to consider, as you read the code above:

- What scope is the variable `player` declared in? Why can we call `takeDamage` on a player outside of that scope?
- Why did Spongebob start at `5` health, but have his health decrease to `2` when `getCurrentHealth` was called?
- What variable do we read from when we call `getCurrentHealth` on spongebob? Is it the same variable or a different variable than the `health` variable in the `takeDamage` function?

As you learn more about tables, building behaviors into tables, and using tables to track data about your software, you can start to use tables like lego pieces, using them together to build more and more complex pieces of software.

## Exercises

Write a script that implements a table, which represents a tic-tac-toe board. The board should be capable of doing the following:

- Placing an `X` or an `O` on a 3x3 game board
- Telling you whether or not the game is over
- Telling you whether `X`s or `O`s have won

This might sound simple on the surface, but there's a lot of complexity under the surface here.

Take a look at the hints below if you get stuck:

<details>
<summary>Hint 1</summary>

Start with a function called `makeTicTacToeGame` which should return a table that has the following functions on it:

- `makeMove = function(symbol, position)` - Returns true if move was successful, else false
- `isGameOver = function()` - Returns either `true` or `false`
- `getWinner = function()` - Returns either `"X"` or `"O"`, or `false` if the game isn't over

</details>

<details>
<summary>Hint 2</summary>

In your `makeTicTacToeGame` function, you will need to store the state of the current game board. You may choose to represent the game board as a table, which contains tables:

```lua
local function makeTicTacToeGame()
  -- more code here
  local gameBoard = {
    topRow = {left = "", middle = "", right = ""},
    middleRow = {left = "", middle = "", right = ""},
    bottomRow = {left = "", middle = "", right = ""}
  }
  -- more code here
end
```

</details>

<details>
<summary>Hint 3</summary>

A workable solution here is to have two tables. One that's "private" and another that's "public". The private table stores the game board and is `local` to the function. The "public" table is returned by `makeTicTacToeGame` and has numerous functions available on it, per the instructions.

The functions available via the public table should read from the game board and perform logic on it. As long as your game board, and the functions that read from and write to your game board are all local to the `makeTicTacToeGame` function scope, the data can be accessed via those functions from outside the scope of `makeTicTacToeGame`.

</details>

<details>
<summary>Hint 4</summary>

Here's a working outline, with some `TODO` blocks for you to complete:

```lua
local function makeTicTacToeGame()
  local gameBoard = {
    topRow = { left = "", middle = "", right = "" },
    middleRow = { left = "", middle = "", right = "" },
    bottomRow = { left = "", middle = "", right = "" }
  }

  local function calculateWinner()
    --[[
      TODO:
      read the positions on the game board and determines
      if either X or O has won. Return the symbol of the winner
      or `false` if no winner has been found
    ]]
  end

  local function isGameOver()
    --[[
      TODO:
      call `calculateWinner`. Return `true` if it returns `"X"` or `"O"`, else return false
    ]]
  end

  local function makeMove(symbol, position)
    --[[
      TODO:
      return false if the position already has a symbol
      change the value of the gameBoard position based on the input of position,
        for example, `gameBoard.topRow.middle = symbol`
      return true
    ]]
  end

  return {
    isGameOver = isGameOver,
    makeMove = makeMove,
    getWinner = calculateWinner,
  }
end

local game = makeTicTacToeGame()
game.makeMove("X", 1) -- numbers represent positions on the board
game.makeMove("O", 3)
game.makeMove("X", 7)
-- and so on
```

</details>
