class Turret
  TILE_KEY = :T
  def initialize x, y
    @pos = Position.new(x,y)
    @ticks = 0
    @detected = false
  end
  
  def turn args
    @detected = within_range args.state.player
    if @detected
      fire args, @detected
    end
  end

  def fire args, side
    pos = side.position(@pos)
    args.state.enemies.push(Fire.new(pos.x, pos.y, side.x, side.y))
  end

  def render args
    tile_in_game(@pos.x, @pos.y, TILE_KEY, RED)
  end

  def collision x, y
      @pos.x == x && @pos.y == y
  end

  def within_range player
    if player.x == @pos.x
      South
    end
    if player.y == @pos.y
      East
    end
  end
end
