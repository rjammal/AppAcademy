class ContactsAddFavorites < ActiveRecord::Migration
  def change
    add_column :contacts, :favorite, :boolean, default: false, null: false
    add_column :contact_shares, :favorite, :boolean, default: false, null: false
  end
end
