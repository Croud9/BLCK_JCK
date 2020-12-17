# frozen_string_literal: true

require_relative 'player'
require_relative 'bank'
require_relative 'deck'

class Game
  def initialize
    @dealer = Player.new({ name: 'Dealer',  cards: [] })
    @bank = Bank.new({ player_account: 100, dealer_account: 100, game_account: 0 })
    init
  end

  def init
    puts "BlackJack
    Как твое имя?"
    user_name = gets.chomp
    puts "Приветсвую, #{user_name}, мы начинаем!"
    @player = Player.new({ name: user_name, cards: [] })
  end

  def start
    @deck = Deck.new
    @player.cards = []
    @dealer.cards = []
    @bank.player_account -= 10
    @bank.dealer_account -= 10
    @bank.game_account += 20
    puts "Ставки сделаны: остаток на Вашем счете #{@bank.player_account},
    у Дилера #{@bank.dealer_account},
    в банке игры: #{@bank.game_account}"
    sleep 1
    puts 'Раздача карт ... '
    sleep 1
    @deck.shuffle
    give_cards(@player, 2)
    give_cards(@dealer, 2)
    info
    next_step
  end

  def next_step
    puts "Ваш ход:
    1. Пропустить ход
    2. Добавить карту
    3. Открыть карты"
    choise = gets.chomp.to_i
    case choise
    when 1
      dealer_move
    when 2
      give_cards(@player, 1) if @player.cards.size < 3
      puts 'Вы взяли карту'
      sleep 1
      info
      check
      dealer_move
    when 3
      open_cards
    end
  end

  def give_cards(player, count)
    while count.positive?
      count -= 1
      player.cards << @deck.cards.slice!(0)
    end
  end

  def count_points(cards)
    points = 0
    cards.each do |card|
      case card[0]
      when /[1KQJ]/
        points += 10
      when /[2-9]/
        points += card[0].to_i
      when /A/
        points += if points <= 10
                    11
                  else
                    1
                  end
      end
    end
    points
  end

  def dealer_move
    puts 'Ход дилера'
    sleep 1
    dealer_points = count_points(@dealer.cards)
    if dealer_points < 16 && @dealer.cards.size < 3
      give_cards(@dealer, 1)
      puts 'Дилер взял карту'
      info
      sleep 1
      next_step if check
    else
      puts 'Дилер пропустил ход'
      sleep 1
      next_step
    end
    info
  end

  def open_cards
    puts 'Вскрываем карты!'
    sleep 2
    dealer_points = count_points(@dealer.cards)
    player_points = count_points(@player.cards)
    puts "Карты дилера: #{@dealer.cards}. Сумма очков: #{dealer_points}"
    puts "Ваши карты: #{@player.cards}. Cумма очков: #{player_points}"
    sleep 1
    if (dealer_points <= 21 && dealer_points > player_points) || player_points > 21
      sleep 1
      puts 'ПОРАЖЕНИЕ'
      @bank.dealer_account += @bank.game_account
      @bank.game_account -= @bank.game_account
    elsif player_points <= 21 && dealer_points < player_points || dealer_points > 21
      sleep 1
      puts 'ПОБЕДА!'
      @bank.player_account += @bank.game_account
      @bank.game_account -= @bank.game_account
    elsif player_points == dealer_points || (player_points > 21 && dealer_points > 21)
      sleep 1
      puts 'НИЧЬЯ'
    end
    puts 'Хотите сыграть еще раз? 1-ДА/ 2-НЕТ'
    if gets.chomp == '1'
      start
    else
      abort 'Спасибо за игру! До встречи!'
    end
  end

  def info
    str = ''
    @dealer.cards.each { str += '*' }
    puts "Карты дилера: #{str}"
    puts "Ваши карты: #{@player.cards} сумма очков: #{count_points(@player.cards)}"
  end

  def check
    if @dealer.cards.size >= 3 && @player.cards.size >= 3
      false
      open_cards
    else
      true
    end
  end
end

game = Game.new
game.start
