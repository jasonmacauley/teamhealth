class QuestionOption < ApplicationRecord
  belongs_to :question
  has_many :response_question_options
end
