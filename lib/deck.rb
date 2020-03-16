class Deck
  attr_reader :cards
  def initialize(cards)
    @cards = cards
  end

  def rank_of_card_at(index)
    @cards[index].rank
  end

  def high_ranking_cards
    @cards.find_all { |card| card.rank >= 11 }
  end

  def percent_high_ranking
    (high_ranking_cards.count.to_f / @cards.count.to_f).round(4) * 100.to_f
  end

  def remove_card
    @cards.shift
  end
end
