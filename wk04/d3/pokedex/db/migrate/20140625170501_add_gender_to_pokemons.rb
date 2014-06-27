class AddGenderToPokemons < ActiveRecord::Migration
  def change
    add_column :pokemons, :gender, :string
  end
end
