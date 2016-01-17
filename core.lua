local up = turtle.up
local down = turtle.down
local left = turtle.turnLeft
local right = turtle.turnRight
local forward = turtle.forward
local back = turtle.back

local xPos, yPos, zPos, rot = false, false, false, false

function wipe()
    term.clear()
    term.setCursorPos(1, 1)
end

if fs.exists("SmartMove/data") and (not isDir("SmartMove/data") then
    local file = fs.open("SmartMove/data", "r")
    local data = textutils.unserialize(file.readAll())
    xPos, yPos, zPos, rot = data.x, data.y, data.z, data.r
    file.close()
else
    while true do
        wipe()
        term.write("Enter X: ")
        xPos = tonumber(read())
        if xPos then
            break
        end
        term.write("Invalid X")
        sleep(1)
    end
    while true do
        wipe()
        term.write("Enter Y: ")
        yPos = tonumber(read())
        if yPos then
            break
        end
        term.write("Invalid Y")
        sleep(1)
    end
    while true do
        wipe()
        term.write("Enter Z: ")
        zPos = tonumber(read())
        if zPos then
            break
        end
        term.write("Invalid Z")
        sleep(1)
    end
    while true do
        wipe()
        term.write("Enter Rotation: ")
        local getRotGUI = read()
        if type(getRotGUI) == "string" then
            rot = ({
                ["north"] = 1,
                ["east"] = 2,
                ["south"] = 3,
                ["west"] = 4
            })[string.lower(getRotGUI)]
        elseif type(getRotGUI) == number then
            rot = getRotGUI
        end
        if rot and (rot >= 1) and (rot <= 4) then
            break
        end
        term.write("Invalid Rotation")
        sleep(1)
    end
end

local saveChanges = coroutine.create(function()
    while true do
        local x, y, z, r = coroutine.yield()
        xPos, yPos, zPos, r = xPos + x, yPos + y, zPos + z, rot + r
        local file = fs.open("SmartMove/data", "w")
        local writeData = {
            ["x"] = xPos,
            ["y"] = yPos,
            ["z"] = zPos,
            ["r"] = rot
        }
        file.write(textutils.serialize(writeData))
        file.close()
    end
end)

local moveTurtle = coroutine.create(function()
    while true do
        
