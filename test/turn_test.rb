require 'minitest/autorun'
require 'minitest/pride'
require './lib/card'
require './lib/deck'
require './lib/player'
require './lib/turn'

class TurnTest < Minitest::Test
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
    @deck2 = Deck.new([@card3, @card4, @card6, @card7])

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

  def test_returns_basic_turn
    assert_equal :basic, @turn.type
    assert_equal @player1, @turn.winner
    @turn.pile_cards
    assert_equal [@card1, @card3], @turn.spoils_of_war
  end

  def test_returns_war_turn
    deck3 = Deck.new([@card1, @card2, @card5, @card8])
    deck4 = Deck.new([@card4, @card3, @card6, @card7])

    player1 = Player.new("Megan", deck3)
    player2 = Player.new("Aurora", deck4)

    turn = Turn.new(player1, player2)
    assert_equal :war, turn.type
    assert_equal player2, turn.winner
    turn.pile_cards
    # assert_equal [@card1, @card2, @card5, @card4, @card3, @card6], turn.spoils_of_war
  end

  def test_returns_mutually_assured_destruction_turn
    card1 = Card.new(:heart, 'Jack', 11)
    card2 = Card.new(:heart, '10', 10)
    card3 = Card.new(:heart, '9', 9)
    card4 = Card.new(:diamond, 'Jack', 11)
    card5 = Card.new(:heart, '8', 8)
    card6 = Card.new(:diamond, '8', 8)
    card7 = Card.new(:heart, '3', 3)
    card8 = Card.new(:diamond, '2', 2)

    deck5 = Deck.new([card1, card2, card5, card8])
    deck6 = Deck.new([card4, card3, card6, card7])

    player1 = Player.new("Megan", deck5)
    player2 = Player.new("Aurora", deck6)

    turn = Turn.new(player1, player2)
    assert_equal :mutually_assured_destruction, turn.type
    assert_equal "No Winner", turn.winner
    turn.pile_cards
    assert_equal [], turn.spoils_of_war
    # assert_equal [card8], turn.deck5
    # assert_equal [card7], turn.deck6
  end
end
