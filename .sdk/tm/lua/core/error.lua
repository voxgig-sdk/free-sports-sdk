-- FreeSports SDK error

local FreeSportsError = {}
FreeSportsError.__index = FreeSportsError


function FreeSportsError.new(code, msg, ctx)
  local self = setmetatable({}, FreeSportsError)
  self.is_sdk_error = true
  self.sdk = "FreeSports"
  self.code = code or ""
  self.msg = msg or ""
  self.ctx = ctx
  self.result = nil
  self.spec = nil
  return self
end


function FreeSportsError:error()
  return self.msg
end


function FreeSportsError:__tostring()
  return self.msg
end


return FreeSportsError
