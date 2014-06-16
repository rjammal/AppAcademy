
class Player

  attr_accessor :pot, :hand, :folded
  
  def initialize(hand, pot)
    @hand = hand
    @pot = pot
    @folded = false
  end
  
  def discard(card_arr)
    card_arr.each do |card|
      @hand.cards.delete(card)
    end
    card_arr.each { |card| @hand.deck.return(card) }
    @hand.cards = @hand.cards + @hand.deck.draw(card_arr.length)
  end
  
  def folds
    @folded = true
  end
  

end