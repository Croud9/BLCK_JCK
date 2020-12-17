# frozen_string_literal: true

class Bank
  attr_accessor :player_account, :dealer_account, :game_account

  def initialize(argument)
    @player_account = argument[:player_account]
    @dealer_account = argument[:dealer_account]
    @game_account = argument[:game_account]
  end
end
