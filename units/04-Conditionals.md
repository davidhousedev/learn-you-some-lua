# Unit 4 - Conditionals

You've learned a lot so far! You're making progress through the fundamentals and will be ready to tackle some challenging problems if you keep at it.

Conditional statements are an essential tool, so let's focus this unit on them.

## Readings

Start here: https://www.lua.org/pil/4.3.1.html

Let's consider the structure of a conditional statement:

```lua
local foo = true

if foo then
  print("foo is true")
end
```

In the example above we:

1. Create a variable `foo` and set it to `true`
2. Begin an `if` statement
3. Check whether `foo` is true
4. Begin an `if` block, beginning a new scope
5. Print that foo is true
6. `end` the `if` block

### Truthy

`if` statements will always check whether or not something is "true". In Lua, it would be more accurate to say that an `if` statement checks if something is **"truthy"**. Let's see what Chat GPT has to say about "truthy":

```
The concept of "truthiness" refers to how non-boolean values are treated in conditions, like those found in if statements or while loops.

In Lua, any value can be used as a condition. The rules are simple:

1. `nil` and `false` are considered "falsy", meaning they're treated as `false` in a condition.
2. All other values are considered "truthy", meaning they're treated as `true` in a condition.

That's it. All values in Lua are truthy except for `nil` and `false`.

Here's an example:
```

```lua
if 0 then
    print("0 is truthy in Lua!")
else
    print("0 is falsy in Lua!")
end
```

```
This will print "0 is truthy in Lua!" because 0 is considered truthy in Lua, unlike some other languages like JavaScript or Python where 0 is considered falsy.
```

Consider the following code block and form some hypotheses about whether or not the `print` statements will run:

```lua
local a = true
local b = false
local c = ""
local d = 0
local e = 55
local f -- this one is tricky!
local g = nil
function h()
  print("h")
end


if a then
  print("a is truthy")
end
if b then
  print("b is truthy")
end
if c then
  print("c is truthy")
end
if d then
  print("d is truthy")
end
if e then
  print("e is truthy")
end
if f then
  print("f is truthy")
end
if g then
  print("g is truthy")
end
if h then
  print("h is truthy")
end
```

### `if`, `elseif`, and `else`

There are three important tools in your conditionals toolbox:

- `if` - Begins a conditional statement
- `elseif` - Sometimes comes after an `if` block, can be used to create multiple mutually-exclusive branches
- `else` - If you use `else`, it's always at the end of a conditional statement, used to execute a block of code if no other condition in the conditional statement matched

Here are some examples:

```lua
local favoriteColor = "blue"

if favoriteColor == "red" then
  print("My favorite color is red")
elseif favoriteColor == "blue" then
  print("My favorite color is blue")
else
  print("lol whats a color")
end
```

```lua
local guess = 2
local answer = 2

if guess == answer then
  print("Your guess is correct!")
else
  print("Nope.")
end
```

```lua
function guessANumber(guess)
  local answer = 4

  if guess == answer then
    return "Correct!"
  else
    return "Incorrect."
  end
end

print(guessANumber(2))
print(guessANumber(3))
print(guessANumber(4))
```

```lua
local favoriteAnimal = "dog"
local favoriteColor = "black"

if favoriteAnimal == "dog" then
  if favoriteColor == "black" then
    print("I like black dogs")
  elseif favoriteColor == "white" then
    print("I like white dogs")
  else
    print("I like dogs")
  end
elseif favoriteAnimal == "turtle" then
  if favoriteColor == "black" then
    print("I like black turtles")
  elseif favoriteColor == "white" then
    print("I like white turtles")
  else
    print("I like turtles")
  end
else
  print("Animals are cool")
end
```

## Exercises

### Mess around with conditionals

For each of the examples above, try the following:

1. Change the variables in the example, then re-run the code to create different results. What can you learn about how conditionals work just by changing the variables?
2. Add additional `elseif` conditions to the existing examples, then modify the variables to test those code paths.
3. Try adding new `if` blocks _within_ existing `if` blocks to add more specificity, as in the final example above.

### Write some conditional code

From scratch, write a function that does the following:

- It accepts at least two arguments
- It always returns a value
- It implements at least one `if` statement that operates on the arguments, from within the function
- It implements at least one `elseif` statement
- It implements at least one `else` statement
- It returns a value _from within_ on of the `if`, `elseif`, or `else` blocks
- It returns a value at the end of the function, outside of all `if`, `elseif`, or `else` blocks

Outside of the function you implement, you should also call your function multiple times, supplying different arguments, and printing the result. When your script is run, it should show multiple conditional paths.

### **Bonus Challenge**

Consider the following code example

```lua
function sum(val1, val2)
  return val1 + val2
end

if sum(2, 2) == 4 then print("✅") else print("❌")
if sum(1, 3) == 4 then print("✅") else print("❌")
if sum(-2, 2) == 0 then print("✅") else print("❌")
if sum(0, 0) == 0 then print("✅") else print("❌")
if sum(0, -1) == -1 then print("✅") else print("❌")
```

If you run this code, it prints the following:

```
✅
✅
✅
✅
✅
```

What does this output _tell you_ about your code? What would you learn from your code if the output was this, instead:

```
❌
❌
❌
✅
❌
```

<details>
<summary>Solution</summary>

`sum` is subtracting instead of adding!

</details>

What about this?

```
✅
❌
❌
✅
❌
```

<details>
<summary>Solution</summary>

`sum` is multiplying instead of adding!

</details>

Can you see why this might be useful? Wouldn't it be helpful to know, every time you run your code, that it's doing exactly what you expect?

The `if` blocks you see in the code sample above are automated _unit tests_. They run your code instantly and let you know if your code is functioning correctly, according to your expectations.

**Here's your challenge**: Write a suite of unit tests for the function you wrote in your second exercise.
