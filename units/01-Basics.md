# Unit 1 - Basics

## Readings

- 2 – Types and Values https://www.lua.org/pil/2.html
  - 2.3 – Numbers https://www.lua.org/pil/2.3.html
  - 2.4 – Strings https://www.lua.org/pil/2.4.html
  - 2.2 – Booleans https://www.lua.org/pil/2.2.html
  - 2.1 – Nil https://www.lua.org/pil/2.1.html
- 3 – Expressions https://www.lua.org/pil/3.html
  - 3.1 – Arithmetic Operators https://www.lua.org/pil/3.1.html
  - 3.2 – Relational Operators https://www.lua.org/pil/3.2.html
  - 3.3 – Logical Operators https://www.lua.org/pil/3.3.html
  - 3.4 – Concatenation https://www.lua.org/pil/3.4.html
  - 3.5 – Precedence https://www.lua.org/pil/3.5.html
- 4 – Statements https://www.lua.org/pil/4.html
  - 4.1 – Assignment https://www.lua.org/pil/4.1.html

## Exercises

### Write a Lua script that prints the following:

- Any number
- Any string
- Any boolean

<details>
<summary>Solution</summary>

```lua
print(42)
print('hello world')
print(true)
```

</details>

### Write a Lua script that prints the following:

- The sum of an addition operation
- The the result of a multiplication
- A first name, a last name, then the combination of a first and last name

<details>
<summary>Solution</summary>

```lua
print(2 + 2)
print(2 * 8)

first_name = 'Spongebob'
last_name = 'Squarepants'
print(first_name)
print(last_name)
print(first_name .. ' ' .. last_name)
```

</details>

### Write a script that prints the following output when run:

```
Weapon Name: Binary Axe of Swinging
Weapon Damage: 80-100
Attack Speed: 1.5s
DPS: 60.0
```

Requirements:

- Store the following values as variables:
  - Weapon minimum damage
  - Weapon maximum damage
  - Attack speed
- Calculate the DPS as an average of the minimum and maximum damage per second. Use the following formula:
  ```
  damage_per_second = (weapon_minimum_damage / attack_speed + weapon_maximum_damage / attack_speed) / 2
  ```

<details>
<summary>Solution</summary>

```lua
weapon_minimum_damage = 80
weapon_maximum_damage = 100
weapon_attack_speed = 1.5

print('Weapon Name: Binary Axe of Swinging')
print('Weapon Damage: ' .. weapon_minimum_damage .. '-' .. weapon_maximum_damage)
print('Attack Speed: ' .. weapon_attack_speed .. 's')

damage_per_second = (weapon_minimum_damage / attack_speed + weapon_maximum_damage / attack_speed) / 2

print('DPS: ' .. damage_per_second)
```

</details>
