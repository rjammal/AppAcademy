# == Schema Information
#
# Table name: pokemons
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  type1      :string(255)
#  type2      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Pokemon < ActiveRecord::Base
  belongs_to :master
  validates :name, :gender, :type1, presence: true

  TYPES = [
    'electric',
    'water', 
    'flying',
    'fire'
  ]
end
