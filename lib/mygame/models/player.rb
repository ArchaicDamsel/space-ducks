class Player
  attr_reader :score

  def initialize(window)
    @image = Gosu::Image.new(window, "assets/rubbergirlduck.png", false)
    @x = @y = @vel_x = @vel_y = @angle = 0.0
    @score = 0
  end
 
  def warp(x, y)
    @x, @y = x, y
  end
 
  def turn_left
    @angle -= 4.5
  end
 
  def turn_right
    @angle += 4.5
  end
 
  def accelerate
    @vel_x += Gosu::offset_x(@angle-90, 0.5)
    @vel_y += Gosu::offset_y(@angle-90, 0.5)
  end
 
  def move
    @x += @vel_x
    @y += @vel_y
    @x %= 640
    @y %= 480
    @vel_x *= 0.95
    @vel_y *= 0.95
  end
 
  def draw(color)
    @image.draw_rot(@x, @y, ZOrder::Player, @angle, 0.5, 0.5, 1, 1, color )
  end

  def score
    @score
  end

  def collect_stars(stars)
    if stars.reject! {|star| Gosu::distance(@x, @y, star.x, star.y) < 35 }
      @score += 1
    end
  end
end
