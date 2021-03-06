# frozen_string_literal: true

require 'set'
require 'card'

describe Card, :unit do
  def card(params = {})
    defaults = {
      suit: :hearts,
      rank: 7
    }

    Card.build(*defaults.merge(params).values_at(:suit, :rank))
  end

  it 'has a suit' do
    expect(card(suit: :spades).suit).to eq(:spades)
  end

  it 'has a rank' do
    expect(card(rank: 4).rank).to eq(4)
  end

  context 'equality' do
    subject { card(suit: :spades, rank: 4) }

    describe 'comparing against self' do
      let(:other) { card(suit: :spades, rank: 4) }

      it 'is equal' do
        expect(subject).to eq(other)
      end

      it 'is hash equal' do
        expect(Set.new([subject, other]).size).to eq(1)
      end
    end

    shared_examples_for 'an unequal card' do
      it 'is not equal' do
        expect(subject).not_to eq(other)
      end

      it 'is not hash equal' do
        expect(Set.new([subject, other]).size).to eq(2)
      end
    end

    describe 'comparing to a card of different suit' do
      let(:other) { card(suit: :hearts, rank: 4) }

      it_behaves_like 'an unequal card'
    end

    describe 'comparing to a card of different rank' do
      let(:other) { card(suit: :spades, rank: 5) }

      it_behaves_like 'an unequal card'
    end
  end

  describe 'a jack' do
    it 'ranks higher than a 10' do
      expect(card(rank: 10).rank).to be < card(rank: :jack).rank
    end
  end

  describe 'a queen' do
    it 'ranks higher than a jack' do
      expect(card(rank: :jack).rank).to be < card(rank: :queen).rank
    end
  end

  describe 'a king' do
    it 'ranks higher than a queen' do
      expect(card(rank: :queen).rank).to be < card(rank: :king).rank
    end
  end

  describe 'an ace' do
    it 'ranks higher than a king' do
      expect(card(rank: :king).rank).to be < card(rank: :ace).rank
    end
  end

  describe '.from_string', :aggregate_failures do
    def self.it_parses(string, card)
      it "parses #{string}" do
        expect(Card.from_string(string)).to eq(card)
      end
    end

    it_parses '7H', Card.build(:hearts, 7)
    it_parses '10S', Card.build(:spades, 10)
    it_parses 'JC', Card.build(:clubs, :jack)
    it_parses 'QC', Card.build(:clubs, :queen)
    it_parses 'KC', Card.build(:clubs, :king)
    it_parses 'AD', Card.build(:diamonds, :ace)
  end
end
