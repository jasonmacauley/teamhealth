class AddPartialNameToQuestionType < ActiveRecord::Migration[6.0]
  def change
    add_column :question_options, :partial_name, :string
  end
end
