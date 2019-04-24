--
-- The contents of this file are Copyright (c) 2019. HAProxy Technologies. All Rights Reserved.
--
-- This file is subject to the terms and conditions defined in
-- file 'LICENSE', which is part of this source code package.

local char_to_hex = function(c)
    return string.format("%%%02X", string.byte(c))
end

local function urlencode(url)
   if url == nil then
      return
  end
  url = url:gsub("\n", "\r\n")
  url = url:gsub("([^%w ])", char_to_hex)
  url = url:gsub(" ", "+")
  return url
end

core.register_converters("urlencode", urlencode)