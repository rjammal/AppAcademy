require 'rspec'
require_relative 'spec_helper'
require 'TTT'
require 'TTT_AI'

describe SuperComputerPlayer do
  subject { SuperComputerPlayer.new }
  let(:winnable_game) do
    test_board = Board.new
    test_board[[0,0]] = :x
    test_board[[0,1]] = :x
    test_board[[1,0]] = :o
    test_board[[1,1]] = :o
    double("TicTacToe", :board => test_board)
  end
  let(:blockable_win_game) do
    test_board = Board.new
    test_board[[0,0]] = :x
    test_board[[1,0]] = :o
    test_board[[1,1]] = :o
    double("TicTacToe", :board => test_board)
  end
  let(:non_winnable_game) do
    test_board = Board.new
    test_board[[0,0]] = :o
    test_board[[2,2]] = :o
    test_board[[2,0]] = :o
    double("TicTacToe", :board => test_board)
  end
  let(:two_moves_to_victory_game) do
    test_board = Board.new
    test_board[[0,0]] = :x
    test_board[[2,2]] = :x
    test_board[[1,1]] = :o
    double("TicTacToe", :board => test_board)
  end


  describe "#move" do
    it "chooses winning move if one is available" do
      expect(subject.move(winnable_game, :x)).to eq([0,2])
    end

    it "can pick a winner that is two moves away" do
      move = subject.move(two_moves_to_victory_game, :x)
      expected_moves = [[0,2], [2,0]]
      expect(expected_moves.find(move)).to_not be_nil
    end

    it "blocks an opponents winning move" do
      #remove our opportunity to win with one move
      expect(subject.move(blockable_win_game, :x)).to eq([1,2])
    end
    it "raises an error if it cannot find a winning or draw inducing move" do
      expect do
        subject.move(non_winnable_game, :x)
      end.to raise_error
    end
  end

end