local up = turtle.up
local down = turtle.down
local left = turtle.turnLeft
local right = turtle.turnRight
local forward = turtle.forward
local back = turtle.back

local xPos, yPos, zPos = 0, 0, 0

if fs.exists("SmartMove/data") and (not isDir("SmartMove/data") then
    local file = fs.open("SmartMove/data", "w")

function saveChanges()
    local x, y, z = coroutine.yield()
    local file = fs.open("SmartMove/data", "
