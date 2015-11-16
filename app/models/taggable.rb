class Taggable < ActiveRecord::Base
  belongs_to :shot
  belongs_to :tag
end
