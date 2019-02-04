-------------------------------------------------------------------------------
-- This contains some of the hairier business logic of the addon.
-------------------------------------------------------------------------------

DEFAULT_STATE = {
    dia = nil,
    bio = nil,
    para = nil,
    slow = nil,
    grav = nil,
    blind = nil,
    shock = nil,
    rasp = nil,
    choke = nil,
    frost = nil,
    burn = nil,
    drown = nil,
}

function handle_action(state, action)
    for _, target in pairs(action.targets) do
        for _, ability in pairs(target.actions) do
            if action.category == 4 then
                -- Set up our state
                local spell = action.param
                local message = ability.message
                state[target.id] = state[target.id] or DEFAULT_STATE

                -- Bio and Dia
                if message == 2 or message == 264 then
                    if spell == 23 or spell == 24 or spell == 25 or spell == 33 then
                        state[target.id].dia = true
                    elseif spell == 230 or spell == 231 or spell == 232 then
                        state[target.id].bio = true
                    end

                    -- Set up timers
                    local timer_id = string.format('%i diabio', target.id)
                    local timer_len = nil

                    if spell == 23 or spell == 33 or spell == 230 then
                        timer_len = 60
                    elseif spell == 24 or spell == 231 then
                        timer_len = 120
                    else--if spell == 25 or spell == 232 then
                        timer_len = 150
                    end

                    ashita.timer.remove_timer(timer_id)
                    ashita.timer.create(timer_id, timer_len, 1, function()
                        state[target.id].dia = nil
                        state[target.id].bio = nil
                    end)
                -- Regular debuffs
                elseif message == 236 or message == 277 then
                    if spell == 58 or spell == 80 then -- para/para2
                        state[target.id].para = true

                        local timer_id = string.format('%i para', target.id)

                        ashita.timer.remove_timer(timer_id)
                        ashita.timer.create(timer_id, 120, 1, function()
                            state[target.id].para = nil
                        end)
                    elseif spell == 56 or spell == 79 then -- slow/slow2
                        state[target.id].slow = true

                        local timer_id = string.format('%i slow', target.id)
                        local timer_len = nil

                        if spell == 56 then
                            timer_len = 120
                        else
                            timer_len = 180
                        end

                        ashita.timer.remove_timer(timer_id)
                        ashita.timer.create(timer_id, timer_len, 1, function()
                            state[target.id].slow = nil
                        end)
                    elseif spell == 216 then -- gravity
                        state[target.id].grav = true

                        local timer_id = string.format('%i grav', target.id)

                        ashita.timer.remove_timer(timer_id)
                        ashita.timer.create(timer_id, 120, 1, function()
                            state[target.id].grav = nil
                        end)
                    elseif spell == 254 or spell == 276 then -- blind/blind2
                        state[target.id].blind = true

                        local timer_id = string.format('%i blind', target.id)

                        ashita.timer.remove_timer(timer_id)
                        ashita.timer.create(timer_id, 180, 1, function()
                            state[target.id].blind = nil
                        end)
                    end
                -- Elemental debuffs
                elseif message == 237 or message == 278 then
                    if spell == 239 then -- shock
                        state[target.id].shock = true

                        local timer_id = string.format('%i shock', target.id)
                        ashita.timer.remove_timer(timer_id)
                        ashita.timer.create(timer_id, 120, 1, function()
                            state[target.id].shock = nil
                        end)
                    elseif spell == 238 then -- rasp
                        state[target.id].rasp = true

                        local timer_id = string.format('%i rasp', target.id)
                        ashita.timer.remove_timer(timer_id)
                        ashita.timer.create(timer_id, 120, 1, function()
                            state[target.id].rasp = nil
                        end)
                    elseif spell == 237 then -- choke
                        state[target.id].choke = true

                        local timer_id = string.format('%i choke', target.id)
                        ashita.timer.remove_timer(timer_id)
                        ashita.timer.create(timer_id, 120, 1, function()
                            state[target.id].choke = nil
                        end)
                    elseif spell == 236 then -- frost
                        state[target.id].frost = true

                        local timer_id = string.format('%i frost', target.id)
                        ashita.timer.remove_timer(timer_id)
                        ashita.timer.create(timer_id, 120, 1, function()
                            state[target.id].frost = nil
                        end)
                    elseif spell == 235 then -- burn
                        state[target.id].burn = true

                        local timer_id = string.format('%i burn', target.id)
                        ashita.timer.remove_timer(timer_id)
                        ashita.timer.create(timer_id, 120, 1, function()
                            state[target.id].burn = nil
                        end)
                    elseif spell == 240 then -- drown
                        state[target.id].drown = true

                        local timer_id = string.format('%i drown', target.id)
                        ashita.timer.remove_timer(timer_id)
                        ashita.timer.create(timer_id, 120, 1, function()
                            state[target.id].drown = nil
                        end)
                    end
                end
            end
        end
    end
end

function handle_basic(state, basic)
    -- if basic.message == 206 then
    --     lin.dump_basic(basic)
    -- end
end
