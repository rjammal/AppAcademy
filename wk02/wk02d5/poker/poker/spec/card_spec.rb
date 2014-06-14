require 'rspec'
require 'card'

describe Card do
  
  describe "#value" do 
    it "returns the value of a high card" do 
      card = Card.new(:king, :hearts)
      expect(card.value).to eq(11)
    end
    
    it "returns the value of an ace" do
      card = Card.new(:ace, :hearts)
      expect(card.value).to eq(12)
    end
    
    it "returns the value of a smaller card" do
      card = Card.new(:five, :hearts)
      expect(card.value).to eq(3)
    end
  end
end