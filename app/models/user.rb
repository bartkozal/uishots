class User < ActiveRecord::Base
  authenticates_with_sorcery!

  has_many :shots, dependent: :destroy
  has_many :tags, through: :shots
  has_many :pins
  has_many :pinned_shots, through: :pins, source: :shot
  has_many :pinned_tags, through: :pinned_shots, source: :tags

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes["password"] }
  validates :password, confirmation: true, if: -> { new_record? || changes["password"] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes["password"] }

  validates :email, presence: true, uniqueness: true, format: /@/
  validates :username, presence: true, uniqueness: true

  def shots_and_pinned_shots
    shots + pinned_shots
  end

  def tags_and_pinned_tags
    tags + pinned_tags
  end

  def not_saved_shot?(shot)
    !shots.include?(shot)
  end

  def pinned_shot?(shot)
    pinned_shots.include?(shot)
  end

  def to_s
    username
  end
end
