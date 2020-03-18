class Turn
  attr_reader :player1, :player2, :spoils_of_war
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @spoils_of_war = []
  end

  def type
    if @player1.deck.rank_of_card_at(0) != @player2.deck.rank_of_card_at(0)
      :basic
    elsif @player1.deck.rank_of_card_at(0) == @player2.deck.rank_of_card_at(0) &&
      @player1.deck.rank_of_card_at(2) != @player2.deck.rank_of_card_at(2)
      :war
    else @player1.deck.rank_of_card_at(0) == @player2.deck.rank_of_card_at(0) &&
      @player1.deck.rank_of_card_at(2) == @player2.deck.rank_of_card_at(2)
      :mutually_assured_destruction
    end
  end

  def winner
    if type == :basic
      @player1.deck.rank_of_card_at(0) > @player2.deck.rank_of_card_at(0)
      @player1
        else @player2
    if type == :war
      @player1.deck.rank_of_card_at(2) > @player2.deck.rank_of_card_at(2)
      @player2
        else @player2
    if type == :mutually_assured_destruction
      "No Winner"
        end
      end
    end
  end

  def players
    [@player1, @player2]
  end

  def pile_cards
    if type == :basic
      spoils_of_war << @player1.deck.cards[0]
      spoils_of_war << @player2.deck.cards[0]
    elsif type == :war
      # creates nested array in array - maybe create players collection +
      # iterate to create single array?
      # cards = []
      # cards << @player1.deck.cards[0..2]
      # cards << @player2.deck.cards[0..2]
      # cards.flat_map do |card|
      #   spoils_of_war << card
    else type == :mutually_assured_destruction
      @player1.deck.cards.drop(0)
      @player1.deck.cards.drop(1)
      @player1.deck.cards.drop(2)

      @player2.deck.cards.drop(0)
      @player2.deck.cards.drop(1)
      @player2.deck.cards.drop(2)

    end
  end

end
