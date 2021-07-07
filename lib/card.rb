# frozen_string_literal: true

class Card
  attr_reader :suit, :rank

  def self.build(suit, rank)
    new(suit: suit, rank: rank)
  end

  private_class_method :new

  def initialize(suit:, rank:)
    @suit = suit
    @rank = case rank
            when :jack then 11
            when :queen then 12
            when :king then 13
            when :ace then 14
            else rank
            end
  end

  def inspect
    to_s
  end

  def to_s
    id = if rank > 10
           {
             11 => 'J',
             12 => 'Q',
             13 => 'K',
             14 => 'A'
           }.fetch(rank)
         else
           rank.to_s
         end

    s = {
      hearts: '♡ ',
      spades: '♤ ',
      diamonds: '♢ ',
      clubs: '♧ '
    }

    "#{id.upcase}#{s.fetch(suit)}"
  end

  def ==(other)
    rank == other.rank && suit == other.suit
  end

  def hash
    [suit, rank].hash
  end

  def eql?(other)
    self == other
  end
end
