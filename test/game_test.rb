require 'minitest/autorun'
require 'minitest/pride'
require './lib/card'
require './lib/deck'
require './lib/player'
require './lib/turn'
require './lib/game'

class GameTest < Minitest::Test
  def setup
    @game = Game.new
    @player1 = Player.new('Megan', @deck1)
    @player2 = Player.new('Aurora', @deck2)
  end

  def test_it_exists
    assert_instance_of Game, @game
  end

  def test_it_has_attributes
    assert_equal [], @game.deck1
    assert_equal [], @game.deck2
  end
end