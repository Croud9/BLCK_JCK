# frozen_string_literal: true

class Card
  attr_reader :suit, :value

  SUIT = %w[+ <3 <> ^].freeze
  VALUE = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze

  def initialize(suit, value)
    @suit = suit
    @value = value
  end
end
