# frozen_string_literal: true

require 'card'

class Deck
  RANKS = (6..9).to_a + %i[jack queen king ace]

  SUITS = %i[hearts clubs diamonds spades].freeze

  def self.all
    SUITS.product(RANKS).map do |suit, rank|
      Card.build(suit, rank)
    end
  end
end
