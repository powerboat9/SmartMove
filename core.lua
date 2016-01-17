local up = turtle.up
local down = turtle.down
local left = turtle.turnLeft
local right = turtle.turnRight
local forward = turtle.forward
local back = turtle.back

local xPos, yPos, zPos = 0, 0, 0

if fs.exists("SmartMove/data") and (not isDir("SmartMove/data") then
    local file = fs.open("SmartMove/data", "r")
    local data = textutils.unserialize(file.readAll())
    xPos, yPos, zPos = data.x, data.y, data.z
    file.close()
end

function saveChanges()
    while true do
        local x, y, z = coroutine.yield()
        xPos, yPos, zPos = xPos + x, yPos + y, zPos + z
        local file = fs.open("SmartMove/data", "w")
        local writeData = {
            ["x"] = xPos,
            ["y"] = yPos,
            ["z"] = zPos
        }
        file.write(textutils.serialize(writeData))
        file.close()
    end
end
