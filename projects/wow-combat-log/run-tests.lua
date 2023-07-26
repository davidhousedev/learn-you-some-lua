-- Custom assert function
local function custom_assert(condition, a, b)
  if not condition then
    error("assertion failed: " .. tostring(a) .. " is not equal to " .. tostring(b), 2)
  end
end

local function scan_and_execute_tests()
  local current_dir = assert(io.popen("ls", "r"))

  local files = {}
  for filename in current_dir:lines() do
    if filename:match("%.lua$") then
      table.insert(files, filename)
    end
  end
  current_dir:close()

  local tests_run = 0
  local tests_passed = 0
  local tests_failed = 0

  for _, file in ipairs(files) do
    local funcs = dofile(file)

    -- Check if funcs is a table before iterating over it
    if type(funcs) == "table" then
      for func_name, func in pairs(funcs) do
        if func_name:match("^test") then
          tests_run = tests_run + 1

          -- Execute the test with custom assert function
          local status, err = pcall(func, custom_assert)

          if status then
            tests_passed = tests_passed + 1
            print("Test " .. func_name .. " PASSED!")
          else
            tests_failed = tests_failed + 1
            print("Test " .. func_name .. " FAILED!\nDebug Information: " .. err)
          end
        end
      end
    end
  end

  print("\n--- Test Summary ---")
  print("Tests Run: " .. tests_run)
  print("Tests Passed: " .. tests_passed)
  print("Tests Failed: " .. tests_failed)
end

scan_and_execute_tests()
