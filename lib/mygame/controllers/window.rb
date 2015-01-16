class Window < Gosu::Window
  def initialize
    super(640, 480, false)
    self.caption = "Let's play a game!"

    @background_image = Gosu::Image.new(self, "assets/outerspace.jpg", true)
 
    @player1 = Player.new(self)
    @player1.warp(360, 240)

    @player2 = Player.new(self)
    @player2.warp(280, 240)

    @star_anim = Gosu::Image::load_tiles(self, "assets/star.png", 25, 25, false)
    @stars = Array.new
  end

  def needs_cursor?
    true
  end

  def startgame
    @gamerunning = true
    @time = Time.now
  end
 
  def update

    if button_down? Gosu::KbReturn
      startgame
    end

    if button_down? Gosu::KbLeft 
      @player1.turn_left
    end
    if button_down? Gosu::KbRight 
      @player1.turn_right
    end
    if button_down? Gosu::KbUp
      @player1.accelerate
    end

    if button_down? Gosu::KbA
      @player2.turn_left
    end
    if button_down?  Gosu::KbD
      @player2.turn_right
    end
    if button_down?  Gosu::KbW
      @player2.accelerate
    end

    @player1.move
    @player2.move
    
    @player1.collect_stars(@stars)
    @player2.collect_stars(@stars)

    if rand(100) < 4 and @stars.size < 25 then
      @stars.push(Star.new(@star_anim))
    end
  end

  def title_screen
      @background_image.draw(0, 0, ZOrder::Background)
      welcome = Gosu::Image.from_text(self, "Welcome to Space Ducks", 
                                    "sans-serif", 30, 2, 300, :center) 
      welcome.draw(160,150,ZOrder::UI)
      start = Gosu::Image.from_text(self, "Push enter to start game!", 
                                    "sans-serif", 20, 2, 300, :center) 
      start.draw(160,250,ZOrder::UI)
  end

  def game_play
    @background_image.draw(0, 0, ZOrder::Background)
    @player1.draw Gosu::Color::WHITE
    @player2.draw Gosu::Color::FUCHSIA
    @stars.each { |star| star.draw }
    duck_score_image("Yellow", @player1.score).draw(350,0,1)
    duck_score_image("Pink", @player2.score).draw(150,0,1)
  end

  def duck_score_image(color, score)
     Gosu::Image.from_text(self, "#{color} duck: #{score}", 
                          "sans-serif", 20, 2, 100, :center)
  end

  def game_over_screen
    @background_image.draw(0, 0, ZOrder::Background)
    show_winner = Gosu::Image.from_text(self, decide_winner, 
                                        "sans-serif", 30, 2, 300, :center) 
    show_winner.draw(160,150,ZOrder::UI)
    score1 = Gosu::Image.from_text(self, "Yellow Ducks's score: #{@player1.score}", 
                                  "sans-serif", 20, 2, 300, :center) 
    score1.draw(160,250,ZOrder::UI)
    score2 = Gosu::Image.from_text(self, "Pink Duck's score: #{@player2.score}", 
                                  "sans-serif", 20, 2, 300, :center) 
    score2.draw(160,300,ZOrder::UI)
    gameover = Gosu::Image.from_text(self, "GAME OVER - push enter to start again.", 
                                    "sans-serif", 20, 2, 300, :center) 
    gameover.draw(160,400,ZOrder::UI)
  end

  def decide_winner
    if @player1.score > @player2.score
      winner = " The winner is Yellow Duck"
    elsif @player2.score > @player1.score
      winner = "The winner is Pink Duck"
    else
      winner = "This match was a draw"
    end
  end
 
  def draw
    if !@gamerunning
      title_screen
    else
      if @time + 60 > Time.now
        game_play
      else
        game_over_screen
      end
    end
  end
 
  def button_down(id)
    if id == Gosu::KbEscape
      close
    end
  end
end

