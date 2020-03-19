require 'minitest/autorun'
require 'minitest/pride'
require './lib/card'
require './lib/deck'
require './lib/player'
require './lib/turn'

class WarTurnTest < Minitest::Test
  def setup
    @card1 = Card.new(:heart, 'Jack', 11)
    @card2 = Card.new(:heart, '10', 10)
    @card3 = Card.new(:heart, '9', 9)
    @card4 = Card.new(:diamond, 'Jack', 11)
    @card5 = Card.new(:heart, '8', 8)
    @card6 = Card.new(:diamond, 'Queen', 12)
    @card7 = Card.new(:heart, '3', 3)
    @card8 = Card.new(:diamond, '2', 2)

    @deck1 = Deck.new([@card1, @card2, @card5, @card8])
    @deck2 = Deck.new([@card4, @card3, @card6, @card7])

    @player1 = Player.new("Megan", @deck1)
    @player2 = Player.new("Aurora", @deck2)

    @turn = Turn.new(@player1, @player2)
  end

  def test_it_exists
    assert_instance_of Turn, @turn
  end

  def test_it_has_attributes
    assert_equal @player1, @turn.player1
    assert_equal @player2, @turn.player2
    assert_equal [], @turn.spoils_of_war
  end

  def test_returns_war_type_of_turn
    assert_equal :war, @turn.type
  end

  def test_returns_war_turn_winner
    assert_equal @player2, @turn.winner
  end

  def test_can_pile_war_turn_cards
    @turn.pile_cards
    spoils_of_war_deck = [@card1, @card2, @card5, @card4, @card3, @card6]
    assert_equal spoils_of_war_deck, @turn.spoils_of_war
    assert_equal [@card8], @player1.deck.cards
    assert_equal [@card7], @player2.deck.cards
  end

  def test_can_award_spoils_for_war_turn
    @turn.pile_cards
    @turn.award_spoils(@player2)
    player2_deck = [@card7, @card1, @card2, @card5, @card4, @card3, @card6]
    assert_equal [@card8], @player1.deck.cards
    assert_equal player2_deck, @player2.deck.cards
  end
end
