# Unit 3 - Scope

Functions are the most important tool in your coding toolbox. Let's practice them!

## Readings

### Function scope

Most every programming language implements the concept of "scope"s. Consider the following description of scopes, courteously of Chat GPT:

```
In programming, "scope" refers to where you can use and access different parts of your code. It's like having different rooms in a house, where each room has its own set of things you can use.

Imagine you have a big house, and each room represents a different part of your program. In each room, you can have things like variables, functions, and objects. The scope determines which rooms can "see" and use these things.

The main types of scopes are:

1. Global Scope: This is like the living room of your house. Variables and functions declared here can be accessed from anywhere in your program. They are like shared resources that everyone can use.

2. Local Scope: These are like smaller rooms within your house, such as bedrooms or bathrooms. Variables and functions declared inside a specific function or block can only be used within that function or block. They are like private resources that only that part of the program can access.

When a scope wants to access a variable, it first looks within its own scope. If the variable is not found, it then looks in the next higher-level scope, and so on, until it reaches the global scope. This is called "variable scoping" or "variable resolution".

If a variable with the same name exists in both the local scope and a higher-level scope, the local scope takes precedence. This is known as "shadowing", where the local variable "shadows" the variable with the same name in the higher-level scope.

Understanding scopes is important because it helps you write code that is easier to manage and less prone to errors. It's like knowing which room to go to when you need something specific in your house.
```

Indeed, understanding scopes is important!

Let's explore each of these concepts in more detail:

- **Global Scope**: by default, any variable defined in Lua exists in the global scope. This means that a variable defined in one part of your function is accessible anywhere else in your code. While this can be useful in some circumstances, global variables can make it very challenging to debug your code when it breaks. It's best to avoid using the global scope whenever possible!
- **Local Assignment**: In Lua, variables are declared _globally by default_. That means any time you define a variable, e.g. `foo = "foo"` then `foo` exists in the global scope and its value is `"foo"`. It's important to only use the global scope when absolutely necessary, so be sure to use the `local` keyword to define variables in your `local` scope.
- **Local Scope**: In Lua, local scopes are created within what are called "blocks". There are multiple ways of defining a new block in Lua. For now, the only tool you've learned is the `function` keyword, which defines a block within the function "body". That is, every line of code between the `function` line and the `end` line is a block that implements a local scope.
- **Variable Resolution**: In Lua, if you reference a variable within a local scope and it doesn't exist, Lua will traverse to the next scope "upwards" until it reaches the global scope. This is a challenging concept to understand, so pay careful attention to the examples below.

### Variable Resolution in Detail

Consider the following example below:

```lua
-- defines `lastName` in the global scope
lastName = "Squarepants"

function sayHello(firstName)
  -- defines `firstName` into the local scope for `sayHello`, via an argument
  -- reads `lastName` from the global scope
  print("Hello " .. firstName .. lastName)
end

function sayGoodbye(firstName)
  -- defines `firstName` into the local scope for `sayGoodbye`, via an argument
  -- reads `lastName` from the global scope
  print("Goodbye" .. firstName .. lastName)
end

sayHello("Spongebob")
sayGoodbye("Spongebob")
```

In this example, there are three different scopes. Can you identify each one?

Now consider this more advanced example, using the `local` keyword to create new variables in a local scope.

```lua
function giveMeANumber()
  -- defines `number` in the local scope of `giveMeANumber`
  local number = 5
  return number
end

print(number) -- what is the value of `number` on this line?
local number = giveMeANumber()
print(number) -- what about this line? did the value of number change?
```

Re-implement this code exactly as-is, but before you run it make a hypothesis about what the result will be. Understanding what's happening in this example is _crucial_ to understanding variable scope.

Let's add some more complexity to this example and see what changes:

```lua
local number = 5

function giveMeANumber()
  return number -- does this variable exist when this function is called?
end

print(number)
local number = giveMeANumber()
print(number)
```

Make another hypothesis about what will happen, then run the code and see what you can learn from the result.

Alright, let's explore one more example. This one is the most complex so pay very careful attention to what is happening:

```lua
local number = 5

function giveMeANumber()
  local number = number -- this is doing something important!

  -- notice that `number` is being re-assigned to a new value
  -- within which scope does this change occur?
  -- does the assignment modify the value in multiple scopes?
  number = number * 2

  return number
end

print(number)
newNumber = giveMeANumber()
print(newNumber)
print(number)
```

Form a hypothesis about what will happen, write and run the code above.

Was your hypothesis correct?

If something about the example above is confusing, try adding some `print` function calls to help you understand what's going on.

## Exercises

### Experiment with scope

Write a script that has the following behaviors:

- Defines at least one variable in the global scope
- Defines multiple variables, across multiple local scopes
- Changes the value of a global variable within a local scope, such that the value in the global scope is changed
- Reads a variable from the global scope into a local scope and changes it, without changing the value in the global scope

Be creative! Challenge yourself! Try to write something complex. Remember that scope can be very confusing to work with, so be sure to make small changes, form a hypothesis about what they will do, test that hypothesis, and learn from it.
