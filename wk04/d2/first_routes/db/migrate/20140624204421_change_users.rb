class ChangeUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.remove :email
      t.rename :name, :username
    end
  end
end
