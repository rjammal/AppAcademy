class CreatePokemons < ActiveRecord::Migration
  def change
    create_table :pokemons do |t|
      t.string :name
      t.string :type1
      t.string :type2

      t.timestamps
    end
  end
end
