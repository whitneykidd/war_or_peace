class Game
  attr_reader :player1, :player2

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
  end

  def start
    p "Welcome to War! (or Peace) This game will be played with 52 cards."
    puts ""
    p "The players today are #{player1.name} and #{player2.name}."
    puts ""
    p "Type 'GO' to start the game!"
    p "---------------------------------------------------------------------"
    user = gets.chomp.upcase

    if user == 'GO'
      p "............... Starting Game ..............."
      play_game
    else
      puts "Invalid input."
      start
    end
  end

  def play_game
    turn_count = 0
    turn = Turn.new(player1, player2)

    until player1.has_lost? || player2.has_lost?
      if turn.type == :basic
        print_cards(player2.deck.cards)
        winner = turn.winner
        turn.pile_cards
        turn.award_spoils(winner)
        turn_count += 1
        puts ""
        p "Turn #{turn_count}: BASIC - #{winner.name} won 2 cards"
        puts ""
        p "Player1 card count = #{player1.deck.cards.count}"
        p "Player2 card count = #{player2.deck.cards.count}"

      elsif turn.type == :war
        print_cards(player2.deck.cards)
        winner = turn.winner
        turn.pile_cards
        turn.award_spoils(winner)
        turn_count += 1
        puts ""
        p "Turn #{turn_count}: WAR - #{winner.name} won 6 cards"
        puts ""
        p "Player1 card count = #{player1.deck.cards.count}"
        p "Player2 card count = #{player2.deck.cards.count}"

      elsif turn.type == :mutually_assured_destruction
        print_cards(player2.deck.cards)
        puts "type is mutually_assured_destruction"
        turn.pile_cards
        turn_count += 1
        puts ""
        p "Turn #{turn_count}: *mutually assured destruction* 6 cards removed from play"
        puts ""
        p "Player1 card count = #{player1.deck.cards.count}"
        p "Player2 card count = #{player2.deck.cards.count}"

      end

      break if turn_count == 100000
      # 1000000
    end
  end

  def print_cards(cards)
    cards.each do |card|
      if card.class == Array
        puts "THIS IS BAD!!!!"
      end
    end
  end
end
