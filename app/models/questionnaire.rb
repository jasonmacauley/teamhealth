class Questionnaire < ApplicationRecord
  has_many :questions
  has_many :responses, through: :questions
  accepts_nested_attributes_for :questions
end
