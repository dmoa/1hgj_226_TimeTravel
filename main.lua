-- cut the game short so I wouldn't run out of time :(

function love.load()

    WW, WH = love.graphics.getDimensions()

    numFarts = 3

    manImg = love.graphics.newImage("man.png")
    guys = {
        {x = 0, running = false, xv = 300}
    }
    waterImg = love.graphics.newImage("water.png")

    clockImg = love.graphics.newImage("clock.png")

    font = love.graphics.newFont(20)
    text = love.graphics.newText(font, "Bored during office hours, you decide to make funny sounds to scare away your cowworkers \n(to let the time pass). \nPress space to do this.")
end

function love.draw()
    love.graphics.setColor(0.8, 0.8, 0.8)
    love.graphics.rectangle("fill", 0, 0, WW, WH)
    love.graphics.setColor(1, 1, 1)
    for index, guy in ipairs(guys) do
        love.graphics.draw(manImg, guy.x, WH - manImg:getHeight())
    end
    love.graphics.draw(waterImg, WW - waterImg:getWidth() - manImg:getWidth(), WH - waterImg:getHeight())
    love.graphics.draw(text, 5, 5)

    love.graphics.draw(clockImg, 400, 55)
end

function love.update(dt)
    for index, guy in ipairs(guys) do 
        guy.x = guy.x + guy.xv * dt
        if guy.x + manImg:getWidth() > WW - waterImg:getWidth() * 2 then
            guy.x = WW - manImg:getWidth() - waterImg:getWidth() * 2
            guy.xv = -300
        end
        if guy.x < 0 and guy.xv < 0 then
            guy.x = 0
            guy.xv = 300
        end
    end
end

function love.keypressed(key)
    if key == "escape" then love.event.quit() end
    if key == "space" and guys[1].x > 650 and not guys[1].running then
        guys[1].xv = -800
        playFart()
    end
end

-- best function I've ever created
function playFart()
    local sound = love.audio.newSource("fart"..love.math.random(numFarts)..".wav", "static")
    sound:play()
end