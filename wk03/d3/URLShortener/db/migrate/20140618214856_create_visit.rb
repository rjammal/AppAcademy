class CreateVisit < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.integer :submitter_id, null: false
      t.integer :short_url_id, null: false
    end
    
    add_index :visits, :submitter_id
    add_index :visits, :short_url_id
  end
end
