local function main()
  -- code goes here
end

local function exampleFunction(val1, val2)
  return val1 * val2
end

local function testMain()
  TEST("EXAMPLE - it can multiply two positive numbers")["expect"](exampleFunction(2, 1))["toEqual"](2)
  TEST("EXAMPLE - it can multiply a positive number and a negative number")["expect"](exampleFunction(5, -1))["toEqual"](
    -5
  )
  TEST("EXAMPLE - it can multiply a number by 0")["expect"](exampleFunction(5, 0))["toEqual"](0)
end



-- Your code goes above this line

if (arg[1] == "--test") then
  --[[
    Use TEST to write a unit test. Run your tests by running `lua54 main.lua --test` in your terminal
  ]]
  function TEST(name)
    local testTable = {}
    local function expect(got)
      local expectTable = {}

      local function toEqual(want)
        if got ~= want then
          print("[-] Failed: " .. name .. " - Expected value (" .. want .. ") was not equal to (" .. got .. ")")
        else
          print("[+] Passed: " .. name)
        end
      end

      expectTable["toEqual"] = toEqual
      return expectTable
    end

    testTable["expect"] = expect
    return testTable
  end

  testMain()
else
  main()
end
