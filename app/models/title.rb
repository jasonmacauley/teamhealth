class Title < ApplicationRecord
  has_many :team_members

  def ==(other)
    other.class == self.class && other.id == id
  end
end
