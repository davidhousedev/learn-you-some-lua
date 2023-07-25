# Unit 5 - Calling multiple functions

## Readings

### How to keep your code DRY

Let's consider abstractions for a moment, in the context of SMS messages sent by your phone. This is an extraordinarily complex process but for our purposes we will break it down to the following steps described as Lua functions:

```lua
-- Function for submitting an SMS to the service center
function submitSms(sms, senderDevice, serviceCenter)
    -- code
end

-- Function for routing SMS to the correct destination
function routeSms(sms, serviceCenter, homeLocationRegister)
    -- code
end

-- Function for delivering SMS to the recipient
function deliver_sms(sms, mobileSwitchingCenter, recipientDevice)
    -- code
end

-- Function for sending delivery receipt back to the sender
function sendDeliveryReceipt(sms, recipientDevice, serviceCenter, senderDevice)
    -- code
end
```

If you were writing a software system that was responsible for delivering SMS messages, you might use these functions like so:

```lua
-- Define the SMS message, sender device, recipient device, service center, etc.
local sms = "Hello, World!"
local senderDevice = "SenderDeviceID"
local recipientDevice = "RecipientDeviceID"
local serviceCenter = "ServiceCenterID"
local homeLocationRegister = "HomeLocationRegisterID"
local mobileSwitchingCenter = "MobileSwitchingCenterID"

-- Call the functions in sequence
submitSms(sms, senderDevice, serviceCenter)
routeSms(sms, serviceCenter, homeLocationRegister)
deliverSms(sms, mobileSwitchingCenter, recipientDevice)
sendDeliveryReceipt(sms, recipientDevice, serviceCenter, senderDevice)
```

Now imagine that your software system needs to send SMS messages in multiple ways, from multiple points in your code. You have two options:

1. Copy-paste the four functions above everywhere
2. ????

Can you guess what the second one is? That's what you're going to learn about today.

Your second option is: "Write another function, that calls all four functions in sequence". Perhaps a function called `sendMessage`?

```lua
function sendMessage(sms, senderDevice, recipientDevice)
  -- lets assume for simplicity's sake that these values are constant
  local homeLocationRegister = "HomeLocationRegisterID"
  local mobileSwitchingCenter = "MobileSwitchingCenterID"

  submitSms(sms, senderDevice, serviceCenter)
  routeSms(sms, serviceCenter, homeLocationRegister)
  deliverSms(sms, mobileSwitchingCenter, recipientDevice)
  sendDeliveryReceipt(sms, recipientDevice, serviceCenter, senderDevice)
end
```

Now, instead of copy-pasting four function calls and six variables multiple points all throughout your code, all you need to copy-paste is this:

```lua
sendMessage("hi", "MyDeviceId", "YourDeviceId")
```

You might be wondering why this is a big deal. Well, what happens if you want to add a new feature to your code for sending SMS messages:

```lua
function sendMessage(sms, senderDevice, recipientDevice)
  -- lets assume for simplicity's sake that these values are constant
  local homeLocationRegister = "HomeLocationRegisterID"
  local mobileSwitchingCenter = "MobileSwitchingCenterID"

  -- new code here 👇🏻
  -- let's say that submitSms returns `true` if it was successful, else `false`
  local success = submitSms(sms, senderDevice, serviceCenter)
  if not success then
    -- retry submission
    submitSms(sms, senderDevice, serviceCenter)
  end
  -- end new code
  routeSms(sms, serviceCenter, homeLocationRegister)
  deliverSms(sms, mobileSwitchingCenter, recipientDevice)
  sendDeliveryReceipt(sms, recipientDevice, serviceCenter, senderDevice)
end
```

Sometimes things can fail, especially when ending SMS messages! When things can fail, it's useful to have retry logic built in to your code, so it can recover.

If you didn't have a `sendMessage` function that kept all the code for sending SMS messages in one place, you'd have to make the same change, in the same way, at every point that you copy-pasted the four functions.

**Enter `DRY`**. DRY is an acronym that stands for "don't repeat yourself". If you find yourself copy-pasting multiple lines of code three or even four places, consider whether that block of code should be _refactored_ into a function. That way, if the logic in those lines ever needs to change you only need to change it once.

## Exercises

The following exercises are going to build off of each other, so avoid the temptation to read them all before you get started. Do one, finish it, then move on to the next

<details>
<summary>Exercise 1</summary>

### Write some REALLY messy code

You've been learning a lot about how to write code that is readable and maintainable. Now it's time to throw all those lessons away and break every single rule. All of them. BREAK THE RULES.

- Write a single function that is at **least 100 lines of code** long (not including empty line breaks)
- Pick from the following rules to break, and build **at least 20 rule breaks** into your code:
  - Rule 1 - Don't modify the value of a global variable
  - Rule 2 - Use consistent casing in your variable and function names
  - Rule 3 - Use human-readable variable and function names (e.g. avoid `z` or abbreviations like `btmn` in place of `batman`)
  - Rule 4 - Use Lua keywords if they are available (e.g. use `not` instead of `~=`)
  - Rule 5 - Avoid duplication, create a function if you are repeating multiple lines of code 3 or more times
- Any time you break a rule, put a code comment referencing the rule that you broke, by number (see above)
- Include **at least 10 `if`, `elseif`, or `else` statements**
- **Do not** use `print` within your function
- Call the function multiple times and `print` the value that is returned, such that every single conditional branch is tested

See the following example:

```lua
function main(someArg1, someArg2, someArg3) -- pick any number of arguments you like
  -- at least 100 lines of code go here, break lots of rules
end

print(main("foo", "bar", "baz"))
print(main("foo", "bar", 1))
print(main("foo", "baz", 9))
-- ... and so on. use different arguments to ensure that every conditional branch is tested
```

</details>

<details>
<summary>Exercise 2</summary>

### Clean everything up

Did you make a huge mess? Great! Now, go clean it up ✨.

The goal of this exercise is to take the code you wrote in Exercise 1 and fix all of your rule breaks _without changing the behavior of the code_. This process is called _refactoring_. When you change code, without changing what it does, you are refactoring your code.

You will be finished with this exercise when:

- All of your rule breaks from Exercise 1 have been corrected
- Your code behaves exactly the same way as in Exercise 1
- Bonus goal: If it makes sense given the script your wrote, split up your logic into smaller functions and compose them together using other functions.

This is the time to write some _absolutely pristine code_. Use this opportunity to practice the skills you've been learning.

</details>

<details>
<summary>Exercise 3</summary>

Bonus exercise

Did you complete the Bonus exercise from `Unit 4`, all about unit tests? **If not, make sure you complete that one before you start this one.**

Reflect on your experience with `Exercise 2` above. Did you encounter any errors while you were refactoring? Did you perhaps break your code while you were trying to fix it? Chances are, you did. It's very easy to break code.

What if you had unit tests instead of `print` statements? Would it have been any easier to catch the error and know how to fix it?

To complete this bonus exercise:

- Re-write all of the print statements as unit tests, such that instead of printing the _value_ that is returned by your code, it prints `✅` when the unit test passes and `❌` when the unit test fails.

</details>
