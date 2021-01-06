class CreateResponseQuestionOptions < ActiveRecord::Migration[6.0]
  def change
    create_table :response_question_options do |t|
      t.integer :response_id
      t.integer :question_option_id

      t.timestamps
    end
  end
end
