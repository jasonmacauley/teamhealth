class Response < ApplicationRecord
  belongs_to :question
  belongs_to :team_member
  has_one :response_question_option
end
