local function backend_with_least_sessions(txn)
    -- Get the frontend that was used
    local fe_name = txn.f:fe_name()

    local least_sessions_backend = ""
    local least_sessions = 99999999999

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
                    core.Debug(backend.name .. ": " .. total_sessions)
                end
            end
          
            if least_sessions > total_sessions then
                least_sessions = total_sessions
                least_sessions_backend = backend.name
            end
        end
    end

    -- Return the name of the backend that has the fewest sessions
    core.Debug("Returning: " .. least_sessions_backend)
    return least_sessions_backend
end

core.register_fetches('leastsess_backend', backend_with_least_sessions)
