# frozen_string_literal: true

class Interface
  def namestart
    puts "BlackJack
   Как твое имя?"
    name = gets.chomp
    puts "Приветсвую, #{name}, мы начинаем!"
    name
  end

  def distribution(player_account, dealer_account, game_account)
    puts "Ставки сделаны: остаток на Вашем счете #{player_account},
   у Дилера #{dealer_account},
   в банке игры: #{game_account}"
    sleep 1
    puts 'Раздача карт ... '
    sleep 1
  end

  def select(choice)
    if choice
      puts "Ваш ход:
   1. Пропустить ход
   2. Добавить карту
   3. Открыть карты"
      gets.chomp.to_i
    end
  end

  def dealer_info
    puts 'Ход дилера'
    sleep 1
  end

  def dealer_take
    puts 'Дилер взял карту'
    sleep 1
  end

  def dealer_skip
    puts 'Дилер пропустил ход'
    sleep 1
  end

  def open
    puts 'Вскрываем карты!'
    sleep 2
  end

  def win
    sleep 1
    puts 'ПОБЕДА!'
  end

  def lose
    sleep 1
    puts 'ПОРАЖЕНИЕ'
  end

  def draw
    sleep 1
    puts 'НИЧЬЯ'
  end

  def info_cards_and_points(args)
    puts "У вас  #{args[:user_score]}, а у дилера  #{args[:dialer_score]}!"
    sleep 1
  end

  def the_end_select
    puts 'Хотите сыграть еще раз? 1-ДА/ 2-НЕТ'
  end

  def end
    puts 'Спасибо за игру! До встречи!'
  end

  def show_cards_on_table(args)
    show_cards_open(args[:user_hand])
    puts " #{args[:user].name}: #{args[:user_hand].score}"
    puts '┅' * 20
    if args[:open_cards]
      show_cards_open(args[:dialer_hand])
      puts " #{args[:dialer].name}: #{"#{args[:dialer_hand].score} "}"
    else
      show_cards_close(args[:dialer_hand])
      puts " #{args[:dialer].name}:  '***'}"
    end
  end

  def show_cards_open(hand)
    hand.cards.each do |card|
      print "#{card.value}#{card.suit} "
    end
  end

  def show_cards_close(hand)
    print ' # ' * hand.cards.count
    puts
  end
end
