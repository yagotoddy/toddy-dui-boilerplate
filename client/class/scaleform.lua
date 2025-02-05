function NewScaleform(data)
  if not data.name or not data.txdName or not data.txnName then
    error("name, txd or txn of scaleForm not found.")
  end

  local handle = RequestScaleformMovie(data.name)
  local timeout = GetGameTimer() + 3000

  repeat
    Wait(10)
    handle = RequestScaleformMovie(data.name)
  until HasScaleformMovieLoaded(handle) or GetGameTimer() >= timeout

  if not HasScaleformMovieLoaded(handle) then
    return nil,'Error loading Scaleform.'
  end

  BeginScaleformMovieMethod(handle,"SET_TEXTURE")
  ScaleformMovieMethodAddParamTextureNameString(data.txdName)
  ScaleformMovieMethodAddParamTextureNameString(data.txnName)
  ScaleformMovieMethodAddParamInt(0)
  ScaleformMovieMethodAddParamInt(0)
  ScaleformMovieMethodAddParamInt(data.width)
  ScaleformMovieMethodAddParamInt(data.height)
  EndScaleformMovieMethod()

  local scaleForm = {}
  scaleForm.handle = handle
  scaleForm.threadStarted = false

  function scaleForm:startThread(scale)
    if not self.handle then
      return nil,'ScaleForm already destroyed or not created.'
    end

    if self.threadStarted then
      return false,'Thread is already started.'
    end

    self.threadStarted = true

    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)

    CreateThread(function()
      while self.handle do
        DrawScaleformMovie_3dSolid(
          self.handle,
          coords.x,coords.y,coords.z + 1.0,
          0.0,0.0,0.0,
          0.0,1.0,0.0,
          scale * 1,scale * (9 / 16),1,
          2
        )
        Wait(0)
      end
    end)
  end

  function scaleForm:destroy()
    if not self.handle then
      return nil,'ScaleForm already destroyed or not created.'
    end

    SetScaleformMovieAsNoLongerNeeded(self.handle)

    self.handle = nil
    self.threadStarted = nil
  end

  if data.start then
    scaleForm:startThread(data.scale or 0.1)
  end

  return scaleForm,'Scaleform created successfully.'
end
