require 'rspec'
require 'player'

describe Player do
  let (:card1) {double("card")}
  let (:card2) {double("card")}
  let (:card3) {double("card")}
  let (:card4) {double("card")}
  let (:card5) {double("card")}
  let (:deck) {double("deck", return: nil, draw: [card1,card2,card3])}
  let (:hand) {double("hand", deck: deck, cards: [card1, card2, card3,
     card4, card5], :cards= => [card4,card5], :+ => [card4, card5])}
  
 
  let (:player) {Player.new(hand, 50)}
  
  
  describe "#discard" do
    
    
    it "removes a card" do
      
      expect(deck).to receive(:return).exactly(3).times
      expect(deck).to receive(:draw).exactly(1).times
      player.discard([card1, card2, card3])
    end
  end
  
end