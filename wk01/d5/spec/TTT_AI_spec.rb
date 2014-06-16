require 'rspec'
require 'spec_helper'
require 'TTT'
require'TTT_AI'
#your file ^^^^^^^^^^ goes here


describe TicTacToeNode do
  let(:empty_board_node) do
    TicTacToeNode.new(Board.new, :x)
  end
  describe '#initialize' do
    it "sets up the instance variables" do
      board = Board.new
      mark = :x
      node = TicTacToeNode.new(board, mark)
      expect(node.board).to eq(board)
      expect(node.next_mover_mark).to eq(mark)
    end
  end

  describe '#children' do
    it "generates 9 children for an empty board" do
      expect(empty_board_node.children.length).to eq(9)
    end

    it "all their marks' are the opposite of their parents'" do
      # p empty_board_node.board.rows
      # p empty_board_node.children.all? do |kid|
      #   kid.next_mover_mark == :o
      # end
      expect(empty_board_node.children.all? do |kid|
        kid.next_mover_mark == :o
      end).to be_true
    end

    it "all their #prev_mov_pos values are their parent's" do
      kids = empty_board_node.children.map{ |kid| kid.prev_move_pos }
      positions = [0,1,2].product([0,1,2])
      expect(kids - positions).to be_empty
    end

    it "the children's boards are dups of the parent's" do
      kid_boards = empty_board_node.children.map{ |kid| kid.board }
      expect(
        kid_boards.none? do |kid_board|
        kid_board.object_id == empty_board_node.object_id
        end
      ).to be_true
    end

    it "doesn't produce children that include non-empty squares" do
      empty_board_node.board[[0,0]] = :x
      empty_board_node.board[[0,1]] = :o
      kids = empty_board_node.children.map{ |kid| kid.prev_move_pos }
      expect(kids.include?([0,0])).to be_false
      expect(kids.include?([0,1])).to be_false
    end
  end

  describe "#losing_node?" do
    it "detects when a node is already in the losing state" do
      empty_board_node.board[[0,0]] = :o
      empty_board_node.board[[0,1]] = :o
      empty_board_node.board[[0,2]] = :o
      expect(empty_board_node.losing_node?(:o)).to be_false
      expect(empty_board_node.losing_node?(:x)).to be_true
    end

    let(:loser) do
      node = TicTacToeNode.new(Board.new, :x)
      node.board[[0,0]] = :o
      node.board[[2,2]] = :o
      node.board[[0,2]] = :o
      node
    end

    context "when it's the player's turn" do
      it "detects when every child is a loser" do
        expect(loser.losing_node?(:x)).to be_true
      end
    end

    context "when it's the opponent's turn" do
      it "detects when any child is a loser" do
        expect(loser.losing_node?(:o)).to be_false
      end
    end
  end

  describe "#winning_node?" do
    let(:winner) do
      node = TicTacToeNode.new(Board.new, :x)
      node.board[[0,0]] = :x
      node.board[[2,2]] = :x
      node.board[[0,2]] = :x
      node
    end
    let(:won_node) do
      node = TicTacToeNode.new(Board.new, :x)
      node.board[[0,0]] = :x
      node.board[[0,1]] = :x
      node.board[[0,2]] = :x
      node
    end
    it "detects when the game is already won" do
      expect(won_node.winning_node?(:o)).to be_false
      expect(won_node.winning_node?(:x)).to be_true
    end
    context "when it's the player's turn" do
      it "detects when any child is a winner" do
        expect(winner.winning_node?(:x)).to be_true
      end
    end
    context "when it's the opponent's turn" do
      it "detects when every child is a winner" do
        expect(winner.winning_node?(:o)).to be_false
      end
    end
  end

end