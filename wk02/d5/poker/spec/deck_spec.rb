require 'rspec'
require 'deck'

describe Deck do
  subject (:deck) {Deck.new}
  describe "#draw" do
    it 'draws one card' do
      draw_result = deck.draw(1)
      expect(draw_result).to be_a(Array)
      expect(draw_result.length).to eq(1)
      expect(draw_result[0]).to be_a(Card)
    end
    
    it "draws multiple cards" do
      draw_result = deck.draw(3)
      expect(draw_result.length).to eq(3)
    end
  end
  
  describe "#return" do
    
    it "puts cards back in the deck" do
      card = deck.draw(1)[0]
      deck.return(card)
      expect(deck.cards).to include(card)
    end
    
    it "shuffles the card into the deck" do
      card = deck.draw(1)[0]
      deck.return(card)
      expect(deck.cards).to include(card)
      expect(deck.draw(1)).to_not eq(card)
    end
  end
  
end