require 'app/turret.rb'
require 'app/fire.rb'


class Enemy
  def initialize pos, tile, color
    @pos = pos
    @tile = tile
    @color = color
  end
  
  def render args
    tile_in_game(@pos.x, @pos.y, @tile, @color)
  end

  def collision other
      @pos.x == other.x && @pos.y == other.y
  end
end

  
