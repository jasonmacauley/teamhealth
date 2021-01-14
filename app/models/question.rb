class Question < ApplicationRecord
  has_many :question_options
  has_many :responses
  belongs_to :questionnaire
  belongs_to :question_type
  accepts_nested_attributes_for :question_options
end
