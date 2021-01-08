class AddLabelToQuestionOption < ActiveRecord::Migration[6.0]
  def change
    add_column :question_options, :label, :string
  end
end
