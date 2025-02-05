local dui
local scaleform

RegisterCommand('send-message-testing', function()
  if not dui then
    print('Dui already destroyed or not created.')
    return
  end

  dui:sendMessage({ action = 'testing', data = 'okay!' })
end,false)

local toogle = false
RegisterCommand('change-url-testing',function()
  if not dui then
    print('Dui already destroyed or not created.')
    return
  end

  toogle = not toogle

  local page = toogle and 'page-one.html' or 'index.html'
  dui:changeUrl('https://cfx-nui-'..GetCurrentResourceName()..'/web/'..page)
end)

AddEventHandler('onClientResourceStart', function(resName)
  if resName ~= GetCurrentResourceName() then return end

  local duiData,duiMessage = NewDui({
    url = 'https://cfx-nui-'..GetCurrentResourceName()..'/web/index.html',
    width = 1920,
    height = 1080,
    txdName = 'dui_txd',
    txnName = 'dui_txn'
  })
  print(duiMessage)
  dui = duiData

  local scaleformData,scaleformMessage = NewScaleform({
    name = 'generic_texture_renderer',
    width = 1920,
    height = 1080,
    start = true,
    scale = 0.1,
    txdName = 'dui_txd',
    txnName = 'dui_txn'
  })
  print(scaleformMessage)

  if not scaleformData then
    local result,message = dui:destroy()
    print(result,message)
    return
  end

  scaleform = scaleformData
end)

AddEventHandler('onResourceStop', function(resName)
  if resName ~= GetCurrentResourceName() then return end

  if dui then
    local result,message = dui:destroy()
    print(result,message)
  end

  if scaleform then
    local result,message = scaleform:destroy()
    print(result,message)
  end
end)