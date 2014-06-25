class ContactRemoveUniquenessEmail < ActiveRecord::Migration
  def change
    remove_index :contacts, :email
    add_index :contacts, :email
  end
end
