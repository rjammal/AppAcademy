class Deck
  
  attr_accessor :cards
  
  def initialize
    card_pairs = Card::VALUES_ARRAY.product(Card::SUITS_ARRAY)
    @cards = card_pairs.map { |pair| Card.new(*pair) }
  end
  
  def shuffle!
    @cards = @cards.shuffle
  end
  
  def draw(num)
    @cards.pop(num)
  end
  
  def return(card)
    @cards.push(card)
    shuffle!
  end
  
end