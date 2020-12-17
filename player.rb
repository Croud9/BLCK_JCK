# frozen_string_literal: true

class Player
  attr_accessor :name, :cards, :cash

  def initialize(argument)
    @name = argument[:name]
    @cards = argument[:cards]
    @name = argument[:cash]
  end
end
