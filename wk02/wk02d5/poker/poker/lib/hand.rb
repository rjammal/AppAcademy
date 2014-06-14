require 'deck'

class Hand
  
  attr_reader :cards, :deck
  
  HAND_SCORES = [:straight_flush?, :four_of_a_kind?, :full_house?, :flush?, 
    :straight?, :three_of_a_kind?, :two_pair?, :one_pair?]
  def initialize(deck, cards = nil)
    cards ||= deck.draw(5)
    @cards = cards
  end
  
  def flush?
    suits = []
    @cards.each do |card| 
      suits << card.suit unless suits.include?(card.suit)
    end
    suits.length == 1
  end
  
  def straight?
    values = @cards.map { |card| card.value }.sort
    return true if [0,1,2,3,12] == values #handles ace, two, three, four, five
    values.each_with_index do |value, i| 
      next if i == values.length - 1
      return false if values[i + 1] - values[i] != 1 
    end
    true 
  end
  
  def straight_flush?
    flush? && straight?
  end
  
  def four_of_a_kind?
    value_frequencies.values.include?(4) 
  end
  
  def three_of_a_kind?
    value_frequencies.values.include?(3) 
  end
  
  def two_pair?
    value_frequencies.values.sort == [1, 2, 2] 
  end
  
  def full_house?
    value_frequencies.values.sort == [2, 3]
  end
  
  def one_pair?
    value_frequencies.values.sort == [1, 1, 1, 2] 
  end
  
  def compare(other_hand)
    own_score = hand_score
    other_score = other_hand.hand_score
    
    if own_score > other_score
      other_hand
    elsif own_score < other_score
      self
    elsif high_card > other_hand.high_card
      self
    elsif high_card < other_hand.high_card
      other_hand
    else
      nil
    end
  end
  
  private 
  
  def value_frequencies
    values_count = Hash.new(0)
    @cards.each { |card| values_count[card.value] += 1 }
    values_count
  end
  
  protected
  
  def hand_score
    HAND_SCORES.each_with_index do |method,i|
      return i if self.send(method)
    end
    8
  end
  
  def high_card
    values = @cards.map(&:value)
    if values.sort == [0, 1, 2, 3, 12]
      3
    else
      values.max
    end
  end
end