class CreateUsersTable < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, uniqueness: true
      t.timestamps
    end
    
  end
end
