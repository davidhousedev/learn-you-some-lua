local function main()
  -- code goes here
end

local function makeLogEntry()
  return "Onyxia hit LeeroyJenkins for 60 damage"
end

local function testMain()
  TEST('it creates a damage log for a player')['expect'](makeLogEntry("DAMAGE", "LeeroyJenkins", "Onyxia", 24))['toEqual']("LeeroyJenkins hit Onyxia for 24 damage")
  TEST('it creates a damage log for a mob')['expect'](makeLogEntry("DAMAGE", "Onyxia", "LeeroyJenkins", 60))['toEqual']("Onyxia hit LeeroyJenkins for 60 damage")
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
