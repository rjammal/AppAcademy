class CreateMasters < ActiveRecord::Migration
  def change
    create_table :masters do |t|
      t.string :name
      t.string :email
      t.string :hometown

      t.timestamps
    end
  end
end
