--
-- The contents of this file are Copyright (c) 2019. HAProxy Technologies. All Rights Reserved.
--
-- This file is subject to the terms and conditions defined in
-- file 'LICENSE', which is part of this source code package.

local function log_work()
    while true do
        core.Debug("Doing some task work!\n")
        core.msleep(10000)
    end
end

core.register_task(log_work)