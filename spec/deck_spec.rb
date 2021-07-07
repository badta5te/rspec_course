require 'deck'

describe 'Deck' do
  describe '.all' do
    it 'contains 32 cards' do
      expect(Deck.all.length).to eq(32)
    end

    it 'has a seven as its lowest card' do
      expect(Deck.all).to all(have_attributes(rank: be >= 7))
    end
  end
end
