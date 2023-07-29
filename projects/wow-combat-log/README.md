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
LeeroyJenkins hit Onyxia 25 Physical
Onyxia hit LeeroyJenkins 80 Physical
LeeroyJenkins hit Onyxia 32 Physical
LeeroyJenkins hit Onyxia 24 Physical
Onyxia hit LeeroyJenkins 74 Physical
Onyxia hit LeeroyJenkins 184 Fire (Critical)
LeeroyJenkins has died
```

Even if the only thing you do for this stage is to add eight `print()` statements in the `main` function, that's enough to move on.

## Stage 2 - Implement a `makeLogEntry` function

For this stage, we're going to start adding some unit tests.

Before you write anything else, add the following test to your `testMain`

```lua
function testMain()
  TEST('it creates a damage log for a player')['expect'](makeLogEntry("DAMAGE", "LeeroyJenkins", "Onyxia", 24))['toEqual']("LeeroyJenkins hit Onyxia 24 Physical")
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
  return "LeeroyJenkins hit Onyxia 24 Physical"
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
  TEST('it creates a damage log for a player')['expect'](makeLogEntry("DAMAGE", "LeeroyJenkins", "Onyxia", 24))['toEqual']("LeeroyJenkins hit Onyxia 24 Physical")
  -- new test here
  TEST('it creates a damage log for a mob')['expect'](makeLogEntry("DAMAGE", "Onyxia", "LeeroyJenkins", 60))['toEqual']("Onyxia hit LeeroyJenkins 60 Physical")
end
```

then re-run your tests

```
lua54 main.lua --test
[+] Passed: it creates a damage log for a player
[-] Failed: it creates a damage log for a mob - Expected value (Onyxia hit LeeroyJenkins 60 Physical) was not equal to (LeeroyJenkins hit Onyxia 24 Physical)
```

Our new test is failing, so let's fix it.

Make the following change to `makeLogEntry`

```lua
local function makeLogEntry()
  return "Onyxia hit LeeroyJenkins 60 Physical"
end
```

And rerun your tests:

```
lua54 main.lua --test
[-] Failed: it creates a damage log for a player - Expected value (LeeroyJenkins hit Onyxia 24 Physical) was not equal to (Onyxia hit LeeroyJenkins 60 Physical)
[+] Passed: it creates a damage log for a mob
```

Okay, let's summarize where we're at:

- You have the beginnings of a function
- You have tests that automatically run your function with reasonable arguments
- You have tests, but they aren't 100% passing

**Time to code!**

This stage will be complete when you can run your tests and have them both pass.

Once your tests are passing, rework the code in your `main` function so that it uses the new `makeLogEntry` whenever possible.

## Stage 3 - Refactor `makeLogEvent` to use tables

There's a rule of thumb when it comes to functions. Generally, they shouldn't accept more than 3 distinct arguments. When you would need a function to accept more three arguments, it's best to refactor that function to accept _one_ argument, where that argument is complex data structure (in Lua, a table).

> Note that this rule doesn't apply to functions which accept an arbitrary number of arguments, for example `print`. `print` can accept any number of arguments (e.g. 1, 2, 4, 99, 24020) and its behavior will adjust. That said, we haven't learned how to write these functions yet!

For this stage, we're going to introduce the idea of an `Event` which uses a table to represent something that occurred in the past. We will represent three events, a damage event, a healing event, and a death event.

We will use a `type` key to differentiate between these events:

```lua
local damageEvent = {type = "DAMAGE"}
local healingEvent = {type = "HEALING"}
local deathEvent = {type = "DEATH"}
```

The event data will be passed into `makeLogEntry`, which will read from the event data and `return` a formatted log entry as a string.

```lua
local function makeLogEntry(event)
  -- TODO!
end
```

For this stage, \*keep all of the `toEqual` parts of your tests exactly the same, but change the arguments passed into the `expect` portion of your test such that they accept events rather than multiple arguments.

**Important:** you will need to add more data to each event type in order to be successful. For example, you will need to specify who triggered the event, who was the target of the event, what was the value associated with the event.

Keep in mind that different events can contain different data, or represent data via different keys. It's up to you how you want to model the rest of your event data.

This stage will be complete when your `makeLogEntry` function defines a single parameter, all of your tests are passing, and when you run your main program it outputs the following:

```
LeeroyJenkins hit Onyxia 25 Physical
Onyxia hit LeeroyJenkins 80 Physical
LeeroyJenkins hit Onyxia 32 Physical
LeeroyJenkins hit Onyxia 24 Physical
Onyxia hit LeeroyJenkins 74 Physical
LeeroyJenkins has died
```

## Stage 4 - Tracking Player Health

So far, the only thing that our project does is print log output. While it is _saying_ that LeeroyJenkins has died, there is something missing from oru code: Nothing is tracking LeeroyJenkins's health.

Let's change that.

### Implement `handleEvent`

We're going to use a Table to track the health of LeeroyJenkins.

Before you implement your function, start by writing the tests:

```lua
function testMain()
  -- other tests above

  --new test
  local player = {
    name = "LeeroyJenkins",
    health = 20,
  }
  local mob = {
    name = "Onyxia",
    health = 4000
  }
  local event = {
    type = "DAMAGE",
    value = 100,
    damageType = "Physical",
    actor = player,
    target = mob
  }

  -- this syntax, using dot notation, works just as well as the syntax above
  -- feel free to choose whichever syntax you prefer
  TEST("handles a damage event")
      .expect(handleEvent(event))
      .toEqual(true)
  TEST("health is lowered")
      .expect(mob.health)
      .toEqual(3900)
end
```

Run your tests, and verify that they fail because `handleEvent` doesn't exist.

```
attempt to call a nil value (global 'handleEvent')
```

Then stub out the function, but don't write any code within it:

```lua
function handleEvent(event)
  -- todo
end
```

and rerun your tests:

```
[-] Failed: handles a damage event - Expected value (true) was not equal to (nill)
[-] Failed: health is lowered - Expected value (3900) was not equal to (4000)
```

Now that you have tests failing because your function isn't implemented, it's time to implement your function.

Once the tests are passing, it's time to integrate `handleEvent` with `makeLogEntry`.

### Refactor `makeLogEntry`

The event structure that you implemented for `handleEvent` may be different than what you implemented in the prior stage for `makeLogEntry`. Let's revise your tests for `makeLogEntry` to ensure that they accept the same event structure as `handleEvent`. That will make it easier to pass events around.

Modify your tests such that they look like this. Notice that the only thing that changes is the input to `makeLogEntry`; the output stays the same:

```lua

local player = {
  name = "LeeroyJenkins",
  health = 20,
}
local mob = {
  name = "Onyxia",
  health = 4000
}
local event = {
  type = "DAMAGE",
  value = 20,
  damageType = "Physical",
  actor = player,
  target = mob
}

TEST("basic damage event")
.expect(makeLogEntry(event))
.toEqual("LeeroyJenkins hit Onyxia 20 Physical")

local player = {
  name = "LeeroyJenkins",
  health = 20,
}

local event = {
  type = "HEALING",
  value = 30,
  damageType = "Holy",
  actor = player,
  target = player
}

TEST("basic healing event")
    .expect(makeLogEntry(event))
    .toEqual("LeeroyJenkins healed themselves 30 Holy")
```

Run your tests, watch them fail, then modify your `makeLogEntry` code to get the tests passing.

### Bring everything together within `handleEvent`

Now that both `handleEvent` and `makeLogEntry` accept the same data, modify `handleEvent` such that it prints the output of `makeLogEntry`:

```lua
function handleEvent(event)
  if event.type == "DAMAGE" then
    event.target.health = event.target.health - event.value
  end

  print(makeLogEntry(event)) -- new code here

  return true
end
```

To finish this stage, you have three tasks:

1. Within `main`, utilize `handleEvent` to print out all damage events
2. Write tests for `handleEvent` to handle a `HEALING` event such that the `event.target` is healed by the `value` of the healing event
3. Extend `main` such that all damage and healing occurs via `handleEvent`. In other words, `main` _should not_ call `makeLogEntry` at all, it should only call `print` or `handleEvent`

When you're done, your `main` function should look something like this:

```lua
  -- create tables for leeroy and onyxia

  print('LeeroyJenkins has entered combat') -- the enter combat feature isn't implemented yet
  -- note, you may choose to create variables for your events then pass them into handle event
  -- or you may create the table for the event when you call the function itself
  -- the choice is yours
  handleEvent(--[[ your code here ]])
  handleEvent(--[[ your code here ]])
  handleEvent(--[[ your code here ]])
  handleEvent(--[[ your code here ]])
  handleEvent(--[[ your code here ]])
  print("Onyxia hit LeeroyJenkins 184 Fire (Critical)") -- the critical damage feature isn't implemented yet
  print("LeeroyJenkins has died") -- the death event feature isn't implemented yet
```

\*_Bonus Challenge_

If you're feeling up for it, try implementing the next few features on your own:

- Allowing damage to be marked as critical
- Automatically printing when someone has died, so you can remove your last `print` statement from `main`
