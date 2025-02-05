function NewDui(data)
  if not data.url or not data.txdName or not data.txnName then
    error('url, txd or txn of scaleForm not found.')
  end

  local dui = {}

  dui.data = {}
  dui.data.txd = CreateRuntimeTxd(data.txdName)
  dui.data.object = CreateDui(data.url,data.width or 1920,data.height or 1080)
  dui.data.handle = GetDuiHandle(dui.data.object)
  dui.data.txt = CreateRuntimeTextureFromDuiHandle(dui.data.txd,data.txnName,dui.data.handle)

  function dui:destroy()
    if not self.data then
      return nil,'Dui already destroyed or not created.'
    end

    if self.data.object then
      DestroyDui(self.data.object)
    end

    self.data = nil
    return true,'Dui destroyed successfully.'
  end

  function dui:sendMessage(message)
    if not self.data then
      return nil,'Dui not found.'
    end

    SendDuiMessage(self.data.object,json.encode(message))
    return true,'Message sent successfully.'
  end

  function dui:changeUrl(newUrl)
    if not self.data then
      return nil,'Dui already destroyed or not created.'
    end

    SetDuiUrl(self.data.object,newUrl)
    return true,'Change in dui url.'
  end

  return dui,'Dui created successfully.'
end