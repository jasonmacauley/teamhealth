class CreateQuestionOptions < ActiveRecord::Migration[6.0]
  def change
    create_table :question_options do |t|
      t.text :text
      t.integer :question_id
      t.integer :value

      t.timestamps
    end
  end
end
