class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :author_id, null: false
      t.text :body
      t.timestamps
    end
    add_index :posts, :author_id
  end
end
