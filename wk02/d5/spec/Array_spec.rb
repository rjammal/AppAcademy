require 'rspec'
require 'Array.rb'
require 'Hanoi.rb'
require 'Game.rb'

describe Array do
  describe "#my_uniq" do
    let (:array) {[1,2,1,3,3]}
    it "should return uniq array" do
      expect(array.my_uniq).to eq([1,2,3])
    end
  end 
  
  describe "#two_sum" do
    it "returns the indicies that sum to zero" do
      array = [-1, 0, 2, -2, 1]
      expect(array.two_sum).to eq([[0, 4], [2, 3]])
    end
  end
end


describe Hanoi do
  let(:hanoi) { Hanoi.new }
  
  describe "#move" do
    before (:each) do
      hanoi.move(1, 2)
    end
    it "moves a piece" do
      expect(hanoi.render).to eq("2 3\n1\n\n")
    end
    
    it "prevents moving a larger disc onto a smaller disc" do
      expect { hanoi.move(1, 2) }.to raise_error(IllegalMove)
    end
    
    it "prevents moving an empty stack" do
      expect { hanoi.move(3, 2)}.to raise_error(IllegalMove)
    end
  end
  
  describe "#render" do
    it "prints a starting game with all discs on left" do
      expect(hanoi.render).to eq("1 2 3\n\n\n")
    end
    
    it "prints a game where some discs are moved" do
      hanoi.move(1, 2)
      hanoi.move(1, 3)
      expect(hanoi.render).to eq("3\n1\n2\n")
    end
  end

  
  describe "#won?" do
    it "returns false when not in a win state" do 
      expect(hanoi.won?).to be_false
    end
    
    it "returns true for win state" do 
      hanoi.move(1, 3)
      hanoi.move(1, 2)
      hanoi.move(3, 2)
      hanoi.move(1, 3)
      hanoi.move(2, 1)
      hanoi.move(2, 3)
      hanoi.move(1, 3)
      expect(hanoi.won?).to be_true
    end
  end
end


describe "my_transpose" do
  it "swaps rows and columns" do
    matrix = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8]
    ]
    expect(my_transpose(matrix)).to eq([[0, 3, 6],
                                        [1, 4, 7],
                                        [2, 5, 8]])
  end
end

describe "stock_picker" do
  context "simple case where highest is after lowest" do 
    it "returns indicies" do
      array = [1,2,3,4,5]
      expect(stock_picker(array)).to eq([0,4])
    end
  end
  
  context "when the highest price is not the biggest difference" do
    it "returns the indices of the most profitable days" do
      array = [5,1,2,3,4]
      expect(stock_picker(array)).to eq([1,4])
    end
  end
end
