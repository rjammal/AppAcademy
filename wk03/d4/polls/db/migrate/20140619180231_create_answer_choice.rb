class CreateAnswerChoice < ActiveRecord::Migration
  def change
    create_table :answer_choices do |t|
      t.integer :question_id, null: false
      t.string :text, null: false, limit: 1024
      
      t.timestamps
    end
    add_index(:answer_choices, :question_id)
  end
end
