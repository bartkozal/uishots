class Tag < ActiveRecord::Base
  has_many :taggables
  has_many :shots, through: :taggables

  validates :name, presence: true

  def to_s
    name
  end
end
