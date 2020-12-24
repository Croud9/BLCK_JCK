# frozen_string_literal: true

class Bank
  attr_accessor :player_account, :dealer_account, :game_account

  def initialize(player_account:, dealer_account:, game_account:)
    @player_account = player_account
    @dealer_account = dealer_account
    @game_account = game_account
  end
end
