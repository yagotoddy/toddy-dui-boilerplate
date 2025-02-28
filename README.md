# toddy-dui-scaleform

A Lua library for managing `Dui` and `Scaleform` creations and interactions in **FiveM** servers. Ideal for integrating dynamic 2D interfaces and 3D animated graphics in your server.

## Features
- Easily create, manage, and destroy `Dui` (Dynamic User Interfaces) and `Scaleform` (3D graphical interfaces).
- Send messages to `Dui` and update their URLs dynamically.
- Render `Scaleform` in 3D with custom scale and position in the game world.
---

## Example Usage

### Creating and Managing a Dui
```lua
RegisterCommand('createDui', function()
  local dui, msg = NewDui({
    url = "http://example.com",
    txdName = "myTxd",
    txnName = "myTxn"
  })
  
  if dui then
    print(msg) -- Dui created successfully.

    -- Send a message to the Dui
    local success, sendMsg = dui:sendMessage({ text = "Hello, world!" })
    print(sendMsg) -- Message sent successfully.

    -- Change the URL of the Dui
    local success, changeMsg = dui:changeUrl("http://new-url.com")
    print(changeMsg) -- URL changed successfully.

    -- Destroy the Dui
    local success, destroyMsg = dui:destroy()
    print(destroyMsg) -- Dui destroyed successfully.
  else
    print(msg) -- Error message if Dui creation failed.
  end
end, false)
```

### Creating and Managing a Scaleform
```lua
RegisterCommand('createScaleform', function()
  local scaleForm, msg = NewScaleform({
    name = "myScaleform",
    txdName = "myTxd",
    txnName = "myTxn",
    width = 1920,
    height = 1080,
    start = true
  })

  if scaleForm then
    print(msg) -- Scaleform created successfully.

    -- Wait for some time and then destroy the Scaleform
    Citizen.Wait(5000)
    scaleForm:destroy()
    print("Scaleform destroyed successfully.")
  else
    print(msg) -- Error message if Scaleform creation failed.
  end
end, false)
```
---
## Available Functions

### `NewDui(data)`
Creates a new Dui object with the given data.
```lua
local dui, msg = NewDui({
  url = "http://example.com",
  txdName = "myTxd",
  txnName = "myTxn"
})
if not dui then
  print(msg)
end
```
- **Parameters:**
  - `url` (string): URL to load into the Dui.
  - `txdName` (string): Name of the texture dictionary.
  - `txnName` (string): Name of the texture within the dictionary.
  - `width` (optional, number): Width of the Dui. Default: 1920.
  - `height` (optional, number): Height of the Dui. Default: 1080.
- **Returns:**
  - `dui` (table): The created Dui object.
  - `msg` (string): Success or error message.

---

### `destroy`
Destroys the created Dui.
```lua
local success, msg = dui:destroy()
print(msg)
```
- **Returns:**
  - `success` (boolean): `true` if the Dui was successfully destroyed, `false` otherwise.
  - `msg` (string): Additional information about the result.

---

### `sendMessage(message)`
Sends a message to the created Dui.
```lua
local success, msg = dui:sendMessage({ text = "Hello, world!" })
print(msg)
```
- **Parameters:**
  - `message` (table): The message to send, typically a table with a `text` field.
- **Returns:**
  - `success` (boolean): `true` if the message was successfully sent, `false` otherwise.
  - `msg` (string): Additional information about the result.

---

### `changeUrl(newUrl)`
Changes the URL of the created Dui.
```lua
local success, msg = dui:changeUrl("http://new-url.com")
print(msg)
```
- **Parameters:**
  - `newUrl` (string): The new URL to set for the Dui.
- **Returns:**
  - `success` (boolean): `true` if the URL was successfully changed, `false` otherwise.
  - `msg` (string): Additional information about the result.

---

### `NewScaleform(data)`
Creates a new Scaleform object with the given data.
```lua
local scaleForm, msg = NewScaleform({
  name = "myScaleform",
  txdName = "myTxd",
  txnName = "myTxn",
  width = 1920,
  height = 1080,
  start = true
})
if not scaleForm then
  print(msg)
end
```
- **Parameters:**
  - `name` (string): Name of the Scaleform to load.
  - `txdName` (string): Name of the texture dictionary.
  - `txnName` (string): Name of the texture within the dictionary.
  - `width` (number): Width of the Scaleform.
  - `height` (number): Height of the Scaleform.
  - `start` (optional, boolean): If `true`, automatically starts the rendering thread. Default: `false`.
- **Returns:**
  - `scaleForm` (table): The created Scaleform object.
  - `msg` (string): Success or error message.

---

### `destroy`
Destroys the created Scaleform.
```lua
scaleForm:destroy()
print("Scaleform destroyed successfully.")
```
- **Returns:**
  - `success` (boolean): `true` if the Scaleform was successfully destroyed, `false` otherwise.
  - `msg` (string): Additional information about the result.
