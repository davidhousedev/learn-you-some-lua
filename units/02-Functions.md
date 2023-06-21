# Unit 2 - Functions

Imagine you have some code for calculating the average of two values, `2`, and `4`:

```lua
average = (2 + 4) / 2
```

This code works great! It calculates the average of two numbers. Ship it!

Imagine what happens when you need to calculate the average of different values in the future:

```lua
new_average = (4 + 8) / 2
```

Hey! It works again. Awesome. Maybe you decide to save some time and copy-paste your code from earlier. Love that.

Later on, you need to calculate another average, this time between three values. Copy-paste to the rescue!

```lua
yet_another_average = (3 + 6 + 9) / 2
```

Did you catch the bug? If not, look carefully at the third average calculation.

<details>
<summary>Solution</summary>
A third value was added to the average, but it's still only dividing by 2. To correct this code, you need to divide by 3.
</details>

Copy-paste is an essential tool when you're coding, but it can also get you in trouble. Let's use functions, an essential programming tool, to prevent bugs that happen when you copy-paste.

## Readings

Functions are originally a mathematical concept. They were adopted by early computer scientists to make it easier to write repeatable code.

Start here: a mathematical explanation of what a function is: https://www.youtube.com/watch?v=kvGsIo1TmsM

In mathematics, functions are often denoted with `f`, and usually have a single parameter `x`. You might see: `f(x) = x + 2` to describe a function that returns its input, plus two.

In programming, functions are given names and often accept multiple parameters. See the following example:

```lua
function sum(x, y)
  return x + y
end
```

We might describe the function above as-follows:

> The function "sum" defines two parameters, x and y. It returns the sum of the arguments.

Now let's invoke that function

```
result = sum(2, 4)
```

We might describe the invocation above as-follows:

> result is equal to the return value of sum, provided the arguments 2, and 4.

## Exercises

Get ready to write a lot of code.

Start with these exercises to get you comfortable with writing and invoking functions.

### Write your first function

Create and run a `exercises-unit-02.lua` file with the following contents:

```lua
function addTwo(x)
  return x + 2
end

print('When you add 2 to 1 you get ' .. addTwo(1))
```

Make sure you can run this file before you proceed. It should print the following:

> When you add 2 to 1 you get 3

### Change its behavior

Try changing the `2` in `addTwo` to a `3` then re-run your code. What happens? After you make this change, should anything else about the function change?

<details>
<summary>Solution</summary>

When you change the code within the function, it changes the behavior of the function. Instead of adding `2`, the function will return the value of its argument plus three.

It might be counter-intuitive for a function called `addTwo` to return its argument plus three. This is a good time to change the function name to `addThree`.

</details>

### Multiply in a new function

Write a new function called `timesTwo` that returns the value of its argument, multiplied by two. Add a new call to `print` to make sure it's working.

<details>
<summary>Solution</summary>

```lua
function timesTwo(x)
  return x * 2
end

print('4 times two is ' .. timesTwo(4))
```

</details>

### Change your parameter name

We have been using `x` as the name of our first parameter. Try something else. Did it work? Try to find three examples of alternative variable names.

<details>
<summary>Solution</summary>

These are three examples of valid parameter names:

- `y`
- `number`
- `SPONGEBOB`

However, these are examples of invalid parameter names:

- `1`
- `true`
- `function`

Why might these be invalid?

</details>

### Re-implement `sum`

In the readings, we discussed a `sum` function that accepts two arguments, `x` and `y`. `sum` should return the values of `x` and `y` added together.

<details>
<summary>Solution</summary>

```lua
function sum(x, y)
  return x + y
end

print('2 plus 2 is ' .. sum(2, 2))
```

</details>

### Add three numbers together

Rework code you already have to add `2`, `2`, and `8` together. There are multiple solutions to this one!

Once you've reached a solution yourself, read the solutions below. Which of the possible solutions do you like the best? Why?

<details>
<summary>Solution</summary>

**Solution 1: Just add 8 at the end**

```lua
function sum(x, y)
  return x + y
end

print('the sum of all the numbers is ' .. sum(2, 2) + 8)
```

**Solution 2: Add 8 within `sum`**

```lua
function sum(x, y)
  return x + y + 8
end

print('the sum of all the numbers is ' .. sum(2, 2))
```

**Solution 3: Add a third parameter**

```lua
function sum(x, y, z)
  return x + y + z
end

print('the sum of all the numbers is ' .. sum(2, 2, 8))
```

Which solution do you like the best? Why?

</details>

### Write your own function

Try writing a function yourself using the tools you already have available. Here are some things to play with:

- The function name, what does it say about what the function returns?
- The number of parameters, is it possible to have too many parameters on a single function?
- The logic inside the function, what else might you accomplish?

### Functions work with strings, too!

Write a function that knights a person. Define a function with a single parameter, that expects a string as an argument. Return that string prepended by `"Ser "`.

<details>
<summary>Solution</summary>

```lua
function knight(first_name)
  return "Ser " .. first_name
end

print('I dub thee ' .. knight("Spongebob"))
```

</details>
