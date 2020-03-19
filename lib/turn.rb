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
      if @player1.deck.rank_of_card_at(0) > @player2.deck.rank_of_card_at(0)
        @player1
      else
        @player2
      end
    else type == :war
      if @player1.deck.rank_of_card_at(2) > @player2.deck.rank_of_card_at(2)
        @player1
      else
        @player2
      end
    end
  end

  def pile_cards
    if type == :basic
      @spoils_of_war << @player1.deck.cards[0] && @player1.deck.cards.delete_at(0)
      @spoils_of_war << @player2.deck.cards[0] && @player2.deck.cards.delete_at(0)

    else type == :war
      @spoils_of_war << @player1.deck.cards[0..2] && delete_cards(@player1)
      @spoils_of_war << @player2.deck.cards[0..2] && delete_cards(@player2)
      @spoils_of_war.flatten!
    end
  end

  def award_spoils(winner)
    if type == :basic || :war
      @spoils_of_war.map do |card|
        winner.deck.cards << card
      end
    end
  end

  def delete_cards(player)
    2.times do
    player.deck.cards.map do |card|
      player.deck.cards.delete_at(0)
      end
    end
  end
end
