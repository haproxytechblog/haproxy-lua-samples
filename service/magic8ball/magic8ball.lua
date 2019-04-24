--
-- The contents of this file are Copyright (c) 2019. HAProxy Technologies. All Rights Reserved.
--
-- This file is subject to the terms and conditions defined in
-- file 'LICENSE', which is part of this source code package.

local function magic8ball(applet)
    -- If client is POSTing request, receive body
    -- local request = applet:receive()

    local responses = {"Reply hazy", "Yes - definitely", "Don't count on it", "Outlook good", "Very doubtful"}
    local myrandom = math.random(1, #responses)
    local response = string.format([[
        <html>
            <body>%s</body>
        </html>
    ]], responses[myrandom])

    applet:set_status(200)
    applet:add_header("content-length", string.len(response))
    applet:add_header("content-type", "text/html")
    applet:start_response()
    applet:send(response)
end

core.register_service("magic8ball", "http", magic8ball)