require 'minitest/autorun'
require 'minitest/pride'
require './lib/card'
require './lib/deck'
require './lib/player'
require './lib/turn'
require './lib/game'

class GameTest < Minitest::Test
  def setup
    @player1 = Player.new('Megan', @deck1)
    @player2 = Player.new('Aurora', @deck2)
    @game = Game.new(@player1, @player2)
  end

  def test_it_exists
    assert_instance_of Game, @game
  end

  def test_it_has_attributes
    assert_equal @player1, @game.player1
    assert_equal @player2, @game.player2
  end
end
