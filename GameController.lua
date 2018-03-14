gameController = {}
gameController.paused = false
gameController.gameOver = false
gameController.width, gameController.height = love.window.getMode()

function gameController:reset(newLevel)
  for i,v in ipairs(player.bullets) do
    table.remove(player.bullets, i)
  end

  for i,v in ipairs(enemyController.enemies) do
    table.remove(enemyController.enemies, i)
  end

  if not newLevel then
    player.score = 0
  end
end

function gameController:newGame()
  self.reset()
  self.gameOver = false
  self.paused = false
  gui.gameOver.enabled = false
  enemyController:init(50, 30)
  enemyController:spawnEnemies()
end
