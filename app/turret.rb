class Turret < Enemy
  TILE_KEY = :T

  def initialize pos
    @ticks = 0
    @detected = false
    super(pos, TILE_KEY, RED)
  end
  
  def turn args
    @detected = see? args.state.player
    if @detected
      fire args, @detected
    end
  end

  def fire args, side
    pos = side.position(@pos)
    args.state.enemies.push(Fire.new(pos, side.x, side.y))
  end

  def see? player
    if player.x == @pos.x
      South
    end
    if player.y == @pos.y
      East
    end
  end
end
