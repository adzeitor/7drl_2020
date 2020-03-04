class Fire
  TILE_KEY = 'water'

  def initialize pos, dx, dy
    @pos = pos
    @dx,@dy = dx, dy
    @ticks = 0
    @color = RED.clone
  end

  def turn args
    @ticks += 1

    @pos.x += @dx
    @pos.y += @dy
    if @ticks >= 10
      @ticks = 0
      action args
    end
  end

  def action args
    :destroy
  end

  def render args
    tile_in_game(@pos.x, @pos.y, TILE_KEY, @color)
  end

  def collision x, y
    @pos.x == x && @pos.y == y
  end
end
