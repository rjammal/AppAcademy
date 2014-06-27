class AddColumnMasterIdToPokemons < ActiveRecord::Migration
  def change
    add_column :pokemons, :master_id, :integer
  end
end
