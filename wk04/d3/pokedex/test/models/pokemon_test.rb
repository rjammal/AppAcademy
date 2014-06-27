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

require 'test_helper'

class PokemonTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
