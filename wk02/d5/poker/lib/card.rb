class Card
  VALUES_ARRAY = [:two, :three, :four, :five, :six, :seven, :eight, :nine, :ten,
    :jack, :queen, :king, :ace]
    
  SUITS_ARRAY = [:hearts, :diamonds, :spades, :clubs]
   
  attr_reader :suit
   
  def initialize(value, suit)
    @value = value
    @suit = suit
  end
  
  def value
    VALUES_ARRAY.find_index(@value)
  end
end