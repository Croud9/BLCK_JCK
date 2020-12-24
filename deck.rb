# frozen_string_literal: true

class Deck
  attr_reader :cards

  def initialize
    @cards = make_cards
  end

  def deal_cards(count)
    @cards.sample(count)
  end

  def deal_one_card
    deal_cards(1)
  end

  def make_cards
    cards = []
    Card::VALUE.each do |value|
      Card::SUIT.each do |suit|
        cards << Card.new(suit, value)
      end
    end
    cards.shuffle!
  end
end
