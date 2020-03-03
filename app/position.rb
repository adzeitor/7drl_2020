class Position
  attr_accessor :x, :y
  def initialize x,y
    @x, @y = x, y
  end
end

class East
  def self.position pos
    Position.new(pos.x+1, pos.y)
  end

  def self.x
    1
  end

  def self.y
    0
  end
end

class West
  def self.position pos
    Position.new(pos.x-1, pos.y)
  end

  def self.x
    -1
  end

  def self.y
    0
  end
end

class North
  def self.position pos
    Position.new(pos.x, pos.y+1)
  end

  def self.x
    0
  end

  def self.y
    1
  end
end

class South
  def self.position pos
    Position.new(pos.x, pos.y-1)
  end

  def self.x
    0
  end

  def self.y
    -1
  end
end
