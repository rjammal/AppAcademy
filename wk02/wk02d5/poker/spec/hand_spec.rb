require 'rspec'
require 'hand'

describe Hand do
  
  let (:deck) {double("deck")}
  
  let (:king_of_hearts) {double('card', suit: :hearts,value: 11)}
  let (:ace_of_hearts) {double('card', suit: :hearts,value: 12)}
  let (:queen_of_hearts) {double('card', suit: :hearts,value: 10)}
  let (:jack_of_hearts) {double('card', suit: :hearts,value: 9)}
  let (:ten_of_hearts) {double('card', suit: :hearts,value: 8)}
  let (:ten_of_spades) {double('card', suit: :spades,value: 8)}
  let (:ten_of_clubs) {double('card', suit: :clubs,value: 8)}
  let (:ten_of_diamonds) {double('card', suit: :diamonds,value: 8)}
  let (:two_of_hearts) {double('card', suit: :hearts,value: 0)}
  let (:three_of_hearts) {double('card', suit: :hearts,value: 1)}
  let (:four_of_hearts) {double('card', suit: :hearts,value: 2)}
  let (:five_of_hearts) {double('card', suit: :hearts,value: 3)}
  let (:ace_of_spades) {double('card', suit: :spades,value: 12)}
  
  describe "check hand status" do
    describe "#flush?" do
      it "should be false if two or more suits" do
        hand = Hand.new(deck, [king_of_hearts, ace_of_hearts, queen_of_hearts, 
          jack_of_hearts, ten_of_spades])
          # expect(hand).to_not be_flush
          expect(hand.flush?).to eq(false)
      end
    
      it "should be true if all same suits" do
        hand = Hand.new(deck, [king_of_hearts, ace_of_hearts, queen_of_hearts, 
          jack_of_hearts, ten_of_hearts])
        expect(hand.flush?).to eq(true)
      end
    end
  
    describe "#straight?" do
      it "returns true if it is a straight" do 
        hand = Hand.new(deck, [king_of_hearts, ace_of_hearts, queen_of_hearts, 
          jack_of_hearts, ten_of_spades])
        expect(hand.straight?).to eq(true)
      end
    
      it "returns false if it is not a straight" do
        hand = Hand.new(deck, [king_of_hearts, ace_of_hearts, queen_of_hearts, 
          ten_of_hearts, ten_of_spades])
        expect(hand.straight?).to eq(false)
      end
    
      it "handles A-5" do
        hand = Hand.new(deck, [two_of_hearts, ace_of_hearts, three_of_hearts, 
          four_of_hearts, five_of_hearts])
        expect(hand.straight?).to eq(true)
      end
    end
  
    describe "#four_of_a_kind?" do
      it "returns false if not four of a kind" do
        hand = Hand.new(deck, [two_of_hearts, ace_of_hearts, three_of_hearts, 
          four_of_hearts, five_of_hearts])
        expect(hand.four_of_a_kind?).to eq(false)
      end
      it "return true if four of a kind" do
        hand = Hand.new(deck, [ten_of_spades, ten_of_diamonds, queen_of_hearts, 
          ten_of_hearts, ten_of_clubs])
        expect(hand.four_of_a_kind?).to eq(true)
      end
    end
  
    describe "#three_of_a_kind?" do
      it "returns false if not three of a kind" do
        hand = Hand.new(deck, [two_of_hearts, ace_of_hearts, three_of_hearts, 
          four_of_hearts, five_of_hearts])
        expect(hand.three_of_a_kind?).to eq(false)
      end
      it "return true if three of a kind" do
        hand = Hand.new(deck, [ten_of_spades, ten_of_diamonds, queen_of_hearts, 
          ten_of_hearts, king_of_hearts])
        expect(hand.three_of_a_kind?).to eq(true)
      end
    end
  
    describe "#two_pair?" do
    
      it "returns true if two pairs" do
        hand = Hand.new(deck, [ten_of_spades, ten_of_diamonds, queen_of_hearts, 
          ace_of_hearts, ace_of_spades])
        expect(hand.two_pair?).to eq(true)
      end
    
      it "returns false for one pair" do 
        hand = Hand.new(deck, [ace_of_spades, ten_of_diamonds, queen_of_hearts, 
          ten_of_hearts, king_of_hearts])
        expect(hand.two_pair?).to eq(false)
      end
    end
  
    describe "#full_house?" do 
      it "returns true for a full house" do 
        hand = Hand.new(deck, [ace_of_spades, ten_of_diamonds, queen_of_hearts, 
          ten_of_hearts, king_of_hearts])
        expect(hand.full_house?).to eq(false)
      end
    
      it "returns false for not a full house" do
        hand = Hand.new(deck, [ten_of_spades, ten_of_diamonds, ten_of_hearts, 
          ace_of_hearts, ace_of_spades])
        expect(hand.full_house?).to eq(true)
      end
    end
  
    describe "#one_pair?" do
    
      it "returns true if one pair" do
        hand = Hand.new(deck, [ten_of_spades, ten_of_diamonds, queen_of_hearts, 
          king_of_hearts, ace_of_spades])
        expect(hand.one_pair?).to eq(true)
      end
    
      it "returns false for not one pair" do 
        hand = Hand.new(deck, [ten_of_spades, ten_of_diamonds, queen_of_hearts, 
          ace_of_hearts, ace_of_spades])
        expect(hand.one_pair?).to eq(false)
      end
    end
  end
  
  describe "comparing hands" do
    
    let (:flush) {Hand.new(deck, [king_of_hearts, ace_of_hearts, 
      queen_of_hearts, jack_of_hearts, ten_of_hearts])}
    let (:lo_straight) {Hand.new(deck, [two_of_hearts, ace_of_spades, 
      three_of_hearts, four_of_hearts, five_of_hearts])}
    let (:hi_straight) {Hand.new(deck, [king_of_hearts, ace_of_hearts, 
      queen_of_hearts, jack_of_hearts, ten_of_spades])}
    let (:one_pair) {Hand.new(deck, [ten_of_spades, ten_of_diamonds, 
      queen_of_hearts, king_of_hearts, ace_of_spades])}
    let (:two_pair) {Hand.new(deck, [ten_of_spades, ten_of_diamonds, 
      queen_of_hearts, ace_of_hearts, ace_of_spades])}
    let (:full_house) {Hand.new(deck, [ten_of_spades, ten_of_diamonds, 
      ten_of_hearts, ace_of_hearts, ace_of_spades])}
    let (:three_of_a_kind) {Hand.new(deck, [ten_of_spades, ten_of_diamonds, 
      queen_of_hearts, ten_of_hearts, king_of_hearts])}
    let (:four_of_a_kind) {Hand.new(deck, [ten_of_spades, ten_of_diamonds, 
      queen_of_hearts, ten_of_hearts, ten_of_clubs])}
    let (:straight_flush) {Hand.new(deck, [king_of_hearts, ace_of_hearts, 
      queen_of_hearts, jack_of_hearts, ten_of_hearts])}
    let (:garbage) {Hand.new(deck, [ace_of_spades, ten_of_diamonds, 
      queen_of_hearts, two_of_hearts, king_of_hearts])}
    
    describe "#compare" do
      it "returns straight flush in: straight_flus vs. two pair" do
        expect(two_pair.compare(straight_flush)).to eq(straight_flush)
      end
      
      it "returns four of a kind in: four of a kind vs. full house" do
        expect(four_of_a_kind.compare(full_house)).to eq(four_of_a_kind)
      end
      
      it "returns one pair in: garbage vs one pair" do
        expect(one_pair.compare(garbage)).to eq(one_pair)
      end
      
      it "compares high card in tied hands" do
        expect(lo_straight.compare(hi_straight)).to eq(hi_straight)
      end
      
      it "returns nil in ties" do
        expect(hi_straight.compare(hi_straight)).to be_nil
      end
    end
  end
end