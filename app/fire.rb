class Fire
  TILE_KEY = 'water'
  def initialize x, y, dx, dy
    @x, @y = x, y
    @dx,@dy = dx, dy
    @ticks = 0
    @color = RED.clone
  end

  def turn args
    @ticks += 1

    @x += @dx
    @y += @dy
    if @ticks >= 10
      @ticks = 0
      action args
    end
  end

  def action args
    :destroy
  end

  def render args
    tile_in_game(@x, @y, TILE_KEY, @color)
  end

  def collision x, y
    @x == x && @y == y
  end
end
