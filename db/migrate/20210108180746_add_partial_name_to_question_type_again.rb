class AddPartialNameToQuestionTypeAgain < ActiveRecord::Migration[6.0]
  def change
    add_column :question_types, :partial_name, :string
    remove_column :question_options, :partial_name
  end
end
