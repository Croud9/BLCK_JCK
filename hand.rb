# frozen_string_literal: true

class Hand
  attr_accessor :cards, :score

  def initialize
    @cards = []
    @score = 0
  end

  def take_cards(cards)
    @cards.concat(cards)
    @score = score
  end

  def over_score?
    @score <= 21
  end

  def score
    total = 0
    ace_count = 0
    @cards.each do |card|
      total += get_card_value(card)
      ace_count += 1 if card.value == 'A'
    end
    total_score_whit_aces(ace_count, total)
  end

  def can_take_card?
    @cards.count <= 3
  end

  def maybe_end?
    @cards.count >= 3
  end

  def get_card_value(card)
    if %w[J Q K].include? card.value
      10
    elsif card.value == 'A'
      0
    else
      card.value.to_i
    end
  end

  def total_score_whit_aces(ace_count, total)
    ace_count.times do
      total += if (total + 11) <= 21
                 11
               else
                 1
               end
    end
    total
  end
end
