# Project - WoW Combat Log

This will be your first big multi-day project. You will start with a very simple implementation then add more and more features as you go.

Once you are done, you will have a basic, functional simulation of WoW combat!

## Getting started

Write your code within `main.lua`. You will find that there's already some code there to get you started.

- `main` - Think of this as the primary function for your program. When you program is run, this is the function that will be called. This function should `return` when your program is finished.
- `exampleFunction` - This is a basic multiply function, here as an example to show you how to use the `TEST` utility
- `testMain` - This is the primary entrypoint for your _unit tests_. Write your tests here.
- `testExampleFunction` - This is a small function where tests are written for `exampleFunction`. Read this code carefully, it teaches you how to use the `TEST` utility.

You can run your code like normal:

```
lua54 main.lua
```

If you want to run your tests, add a `--test` flag to the end of your command

```
lua54 main.lua --test
```

Let's begin.

## Stage 1 - Printing combat log events

At the end of this stage, your combat log should print the following to the terminal:

```
LeeroyJenkins entered combat
LeeroyJenkins hit Onyxia for 25 damage
Onyxia hit LeeroyJenkins for 80 damage
LeeroyJenkins hit Onyxia for 32 damage
LeeroyJenkins hit Onyxia for 24 damage
Onyxia hit LeeroyJenkins for 74 damage
Onyxia hit LeeroyJenkins for 184 fire damage
LeeroyJenkins has died
```

Even if the only thing you do for this stage is to add eight `print()` statements in the `main` function, that's enough to move on.
