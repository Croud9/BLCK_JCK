# frozen_string_literal: true

class Deck
  attr_reader :cards

  def initialize
    @cards = []
    suits = %w[+ <3 <> ^]
    values = %w[2 3 4 5 6 7 8 9 10 J Q K A]
    suits.each do |suit|
      values.each { |value| @cards << value.to_s + suit }
    end
  end

  def shuffle
    @cards.shuffle!
  end
end
