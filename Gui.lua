gui = {}
gui.score = {}
gui.score.x = 0
gui.score.y = 0
gui.score.text = ""
gui.score.enabled = true

gui.gameOver = {}
gui.gameOver.x = 0
gui.gameOver.y = 600
gui.gameOver.text = "Game Over"
gui.gameOver.enabled = false

function gui:draw()
  if gui.gameOver.enabled then
    love.graphics.setColor(255, 0, 0, 255)
    love.graphics.printf(gui.gameOver.text, gui.gameOver.x, gui.gameOver.y, 480, "center")
  end

  if gui.score.enabled then
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.printf(tostring(player.score), gui.score.x, gui.score.y, 480, "center")
  end

end
