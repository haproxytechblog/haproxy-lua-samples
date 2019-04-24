--
-- The contents of this file are Copyright (c) 2019. HAProxy Technologies. All Rights Reserved.
--
-- This file is subject to the terms and conditions defined in
-- file 'LICENSE', which is part of this source code package.

local function backend_with_least_sessions(txn)
    -- Get the frontend that was used
    local fe_name = txn.f:fe_name()

    local result = {}

    -- Loop through all the backends. You could change this
    -- so that the backend names are passed into the function too.
    for _, backend in pairs(core.backends) do

        -- Look at only backends that have names that start with
        -- the name of the frontend, e.g. "www_" prefix for "www" frontend.
        if backend and backend.name:sub(1, #fe_name + 1) == fe_name .. '_' then
            local total_sessions = 0

            -- Using the backend, loop through each of its servers
            for _, server in pairs(backend.servers) do

                -- Get server's stats
                local stats = server:get_stats()

                -- Get the backend's total number of current sessions
                if stats['status'] == 'UP' then
                    total_sessions = total_sessions + stats['scur']
                end
            end

            table.insert(result, {name = backend.name, total = total_sessions })
        end
    end

    -- Sort the backends by least number of sessions first
    table.sort(result, function(a, b) return a['total'] < b['total'] end)

    for k, v in pairs(result) do
        core.Debug(k .. ": " .. v['name'] .. ", " .. v['total'])
    end

    -- Return the name of the backend that has the fewest sessions
    local k,v = next(result)
    core.Debug("Returning: " .. v['name'])
    return v['name']
end

core.register_fetches('leastsess_backend', backend_with_least_sessions)