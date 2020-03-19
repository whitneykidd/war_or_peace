class Turn
  attr_reader :player1, :player2, :spoils_of_war
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @spoils_of_war = []
  end

  def type
    if zero_index_rank(@player1) != zero_index_rank(@player2)
      :basic
    elsif zero_index_rank(@player1) == zero_index_rank(@player2) &&
      two_index_rank(@player1) != two_index_rank(@player2)
      :war
    else
      :mutually_assured_destruction
    end
  end

  def zero_index_rank(player)
    player.deck.rank_of_card_at(0)
  end

  def two_index_rank(player)
    player.deck.rank_of_card_at(2)
  end

  def winner
    if type == :basic
      if zero_index_rank(@player1) > zero_index_rank(@player2)
        @player1
      else
        @player2
      end

    elsif type == :war
      if two_index_rank(@player1) > two_index(@player2)
        @player1
      else
        @player2
      end

    else
      "No Winner"
    end
  end

  def pile_cards
    if type == :basic
      @spoils_of_war << @player1.deck.cards[0] && @player1.deck.cards.delete_at(0)
      @spoils_of_war << @player2.deck.cards[0] && @player2.deck.cards.delete_at(0)

    elsif type == :war
      @spoils_of_war << @player1.deck.cards[0..2] && delete_cards(@player1)
      @spoils_of_war << @player2.deck.cards[0..2] && delete_cards(@player2)
      @spoils_of_war.flatten!

    else
      delete_cards(@player1)
      delete_cards(@player2)
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
