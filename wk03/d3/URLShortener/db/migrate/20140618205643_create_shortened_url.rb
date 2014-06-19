class CreateShortenedUrl < ActiveRecord::Migration
  def change
    create_table :shortened_urls do |t|
      t.text :long_url, null: false
      t.string :short_url, null: false, uniqueness: true
      t.integer :submitter_id, null: false
      
      t.timestamps
    end
    
    add_index :users, :email
    add_index :shortened_urls, :submitter_id
    add_index :shortened_urls, :short_url
  end
end
