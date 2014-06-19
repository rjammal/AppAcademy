class CreateTagging < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.integer :tag_topic_id, null: false
      t.integer :short_url_id, null: false
      
      t.timestamps
    end
    
    add_index :taggings, :tag_topic_id
    add_index :taggings, :short_url_id
  end
end
