# frozen_string_literal: true

class Game
  def initialize
    @interface = Interface.new
    @bank = Bank.new({ player_account: 100, dealer_account: 100, game_account: 0 })
    @dialer = Dialer.new
    @user = User.new({ name: @interface.namestart })
    start
  end

  def start
    @open_cards = false
    @deck = Deck.new
    start_turn_bank
    make_hands
    deal_cards
    @interface.distribution(@bank.player_account, @bank.dealer_account, @bank.game_account)
    show_info
    next_step
  end

  def make_hands
    @user_hand = Hand.new
    @dialer_hand = Hand.new
  end

  def deal_cards
    @user_hand.take_cards(@deck.deal_cards(2))
    @dialer_hand.take_cards(@deck.deal_cards(2))
  end

  def start_turn_bank
    @bank.player_account -= 10
    @bank.dealer_account -= 10
    @bank.game_account += 20
  end

  def next_step
    choise = @interface.select(@user_hand.can_take_card?)
    case choise
    when 1
      dealer_move
    when 2
      add_card
    when 3
      open_cards
    end
  end

  def add_card
    @user_hand.take_cards(@deck.deal_cards(1)) if @user_hand.can_take_card? && @dialer_hand.over_score?
    show_info
    sleep 1
    check
    dealer_move
  end

  def dealer_move
    @interface.dealer_info
    if @dialer_hand.can_take_card? && @dialer_hand.over_score?
      if take_more_card?(@dialer_hand.score)
        @dialer_hand.take_cards(@deck.deal_one_card)
        @interface.dealer_take
        next_step if check
      else
        @interface.dealer_skip
        next_step
      end
    else
      open_cards
    end
  end

  def open_cards
    @interface.open
    @interface.info_cards_and_points(game_results)
    if @user_hand.score == @dialer_hand.score
      @interface.draw
    elsif (@user_hand.score > @dialer_hand.score && @user_hand.over_score?) || @dialer_hand.score > 21
      gamer_win
    elsif (@user_hand.score < @dialer_hand.score && @dialer_hand.over_score?) || @user_hand.score > 21
      gamer_lose
    end
    the_end
  end

  def the_end
    @interface.the_end_select
    imput = gets.chomp.to_i
    case imput
    when 1
      start
    when 2
      @interface.end
      abort
    end
  end

  def gamer_win
    @interface.win
    @bank.player_account += @bank.game_account
    @bank.game_account -= @bank.game_account
  end

  def gamer_lose
    @interface.lose
    @bank.dealer_account += @bank.game_account
    @bank.game_account -= @bank.game_account
  end

  def take_more_card?(score)
    score < 16
  end

  def check
    if @dialer_hand.maybe_end? && @user_hand.maybe_end?
      false
      open_cards
    else
      true
    end
  end

  def game_results
    { user_score: @user_hand.score,
      dialer_score: @dialer_hand.score }
  end

  def show_info
    @interface.show_cards_on_table({ user: @user, user_hand: @user_hand,
                                     dialer: @dialer, dialer_hand: @dialer_hand, open_cards: @open_cards })
  end
end
