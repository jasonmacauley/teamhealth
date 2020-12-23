class OrganizationType < ApplicationRecord
  has_many :organizations

  def ==(other)
    other.class == self.class && id.equal?(other.id) ? true : false
  end
end
