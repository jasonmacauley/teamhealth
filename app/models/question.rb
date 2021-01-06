class Question < ApplicationRecord
  has_many :question_options
  belongs_to :questionnaire
  belongs_to :question_type
end
