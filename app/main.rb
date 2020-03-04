require 'app/constants.rb'
require 'app/sprite_lookup.rb'
require 'app/legend.rb'
require 'app/enemies.rb'
require 'app/position.rb'

def tick args
  tick_game args
  #  tick_legend args
  render args
end

def turn args, x, y 
  found_enemy = args.state.enemies.find do |e|
    e.collision(x, y)
  end

  if !found_enemy
    args.state.player.x = x
    args.state.player.y = y
    args.state.info_message = "You moved"
  else
    args.state.info_message = "You cannot move into a square an enemy occupies."
  end


  args.state.enemies.select! do |e|
    if e.turn(args) == :destroy
      false
    else
      true
    end
  end
end

def tick_game args
  # setup the grid
  args.state.grid.padding = 104
  args.state.grid.size = 512

  # set up your game
  # initialize the game/game defaults. ||= means that you only initialize it if
  # the value isn't alread initialized
  args.state.player.x ||= 0
  args.state.player.y ||= 0

  args.state.enemies ||= [
    Fire.new(Position.new(5,10), 1, 0)
    Turret.new(Position.new(5, 5)),
    Turret.new(Position.new(5, 7)),
    Turret.new(Position.new(5, 9)),
  ]



  args.state.info_message ||= "Use arrow keys to move around."

  # handle keyboard input
  # keyboard input (arrow keys to move player)
  new_player_x = args.state.player.x
  new_player_y = args.state.player.y
  player_direction = ""
  player_moved = false
  if args.inputs.keyboard.key_up.up
    new_player_y += 1
    player_direction = "north"
    player_moved = true
  elsif args.inputs.keyboard.key_up.down
    new_player_y -= 1
    player_direction = "south"
    player_moved = true
  elsif args.inputs.keyboard.key_up.right
    new_player_x += 1
    player_direction = "east"
    player_moved = true
  elsif args.inputs.keyboard.key_up.left
    new_player_x -= 1
    player_direction = "west"
    player_moved = true
  end

  #handle game logic
  # determine if there is an enemy on that square,
  # if so, don't let the player move there
  if player_moved
    turn args, new_player_x, new_player_y
  end
end

def render args
  args.outputs.sprites << tile_in_game(args.state.player.x,
                                       args.state.player.y,
                                       '@', DEFAULT_COLOR)

  # render game
  # render enemies at locations
  args.outputs.sprites << args.state.enemies.map do |e|
    e.render args
  end

  # render the border
  border_x = args.state.grid.padding - DESTINATION_TILE_SIZE
  border_y = args.state.grid.padding - DESTINATION_TILE_SIZE
  border_size = args.state.grid.size + DESTINATION_TILE_SIZE * 2

  args.outputs.borders << [border_x,
                           border_y,
                           border_size,
                           border_size]

  # render label stuff
  args.outputs.labels << [border_x, border_y - 10, "Current player location is: #{args.state.player.x}, #{args.state.player.y}"]
  args.outputs.labels << [border_x, border_y + 25 + border_size, args.state.info_message]
end

def tile_in_game(x, y, tile_key, color)
  tile($gtk.args.state.grid.padding + x * DESTINATION_TILE_SIZE,
       $gtk.args.state.grid.padding + y * DESTINATION_TILE_SIZE,
       tile_key, color)
end
