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

## Stage 2 - Implement a `makeLogEntry` function

For this stage, we're going to start adding some unit tests.

Before you write anything else, add the following test to your `testMain`

```lua
function testMain()
  TEST('it creates a damage log for a player')['expect'](makeLogEntry("DAMAGE", "LeeroyJenkins", "Onyxia", 24))['toEqual']("LeeroyJenkins hit Onyxia for 24 damage")
end
```

Now save your file and run your tests. You should encounter an error:

```
lua: main.lua:6: attempt to call a nil value (global 'makeLogEntry')
stack traceback:
	main.lua:6: in local 'testMain'
	main.lua:37: in main chunk
	[C]: in ?
```

This error makes sense. You're calling a function that doesn't exist yet.

Now that this test exists, your tests will fail if `makeLogEntry` is ever deleted. We want that function to exist, so that's progress!

Now implement the function like so:

```lua
local function makeLogEntry()
  return "LeeroyJenkins hit Onyxia for 24 damage"
end
```

Save your file, and run your tests:

```
lua54 main.lua --test
[+] Passed: it creates a damage log for a player
```

Passing test! Excellent. Time to move on.

Yes, I'm serious. It is time to move on.

You might be asking yourself some very reasonable questions:

- Why are we passing arguments to a function that doesn't have any parameters?
- Why are we hard-coding a return value, when we might want to change the way that this function returns?

Let's take a moment to describe what we're trying to do here:

We can test our code one of two ways:

1. Manually
2. Automatically

You're very familiar with manual testing. It's time-consuming, it's tedious, and it works. If want to test every behavior for how your code works, you might have to test multiple times and carefully inspect the results to be sure your code is working.

Now what if you had automated tests for every single feature of your code. If every feature, _every single feature_ had a test that expected its behavior, all you'd need to do is re-run your tests and you'll know that your code is working. Ta-da! No more manual testing.

**But how do you know if your tests are working?** That's the key. Automated tests are _code_. Code can have bugs. Therefore, automated tests can have bugs. This is a legitimate problem. Here's the solution:

Manually test your tests, so they can automatically test your code.

That's it.

How do you manually test your tests? Well, you might think that running them and watching them pass is good enough, but that's not always true. Sometimes, an automated test can be a "false positive". A false positive is a passing test that doesn't actually test your code. The only way to prevent false positives is to do the following:

1. Write your test
2. Run your test and _watch it fail_
3. Write _just enough code_ to make the test pass

That's what we're doing. Let's continue!

Add another test:

```lua
local function testMain()
  TEST('it creates a damage log for a player')['expect'](makeLogEntry("DAMAGE", "LeeroyJenkins", "Onyxia", 24))['toEqual']("LeeroyJenkins hit Onyxia for 24 damage")
  -- new test here
  TEST('it creates a damage log for a mob')['expect'](makeLogEntry("DAMAGE", "Onyxia", "LeeroyJenkins", 60))['toEqual']("Onyxia hit LeeroyJenkins for 60 damage")
end
```

then re-run your tests

```
lua54 main.lua --test
[+] Passed: it creates a damage log for a player
[-] Failed: it creates a damage log for a mob - Expected value (Onyxia hit LeeroyJenkins for 60 damage) was not equal to (LeeroyJenkins hit Onyxia for 24 damage)
```

Our new test is failing, so let's fix it.

Make the following change to `makeLogEntry`

```lua
local function makeLogEntry()
  return "Onyxia hit LeeroyJenkins for 60 damage"
end
```

And rerun your tests:

```
lua54 main.lua --test
[-] Failed: it creates a damage log for a player - Expected value (LeeroyJenkins hit Onyxia for 24 damage) was not equal to (Onyxia hit LeeroyJenkins for 60 damage)
[+] Passed: it creates a damage log for a mob
```

Okay, let's summarize where we're at:

- You have the beginnings of a function
- You have tests that automatically run your function with reasonable arguments
- You have tests, but they aren't 100% passing

**Time to code!**

This stage will be complete when you can run your tests and have them both pass.
