class Shot < ActiveRecord::Base
  belongs_to :user
  has_many :taggables, dependent: :destroy
  has_many :tags, through: :taggables
  has_many :pins

  validates :url, presence: true
  validates :tag_list, presence: true

  attr_accessor :tag_list
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h

  def fetch_screenshot(url)
    FetchScreenshotJob.perform_later(url)
  end

  def crop_screenshot
    tmp_path = "screenshots/#{tmp_filename}"
    path = "screenshots/cropped/#{SecureRandom.hex(24)}.png"

    CropScreenshotJob.perform_later(tmp_path, path, crop_w, crop_h, crop_x, crop_y)

    [tmp_path, path]
  end

  def tmp_image_url
    "//uishots-assets.s3-website-us-east-1.amazonaws.com/screenshots/#{tmp_filename}"
  end

  def image_url
    "//uishots-assets.s3-website-us-east-1.amazonaws.com/#{image}"
  end

  private

  def tmp_filename
    "#{url.delete('/.:?!')}.png"
  end
end
