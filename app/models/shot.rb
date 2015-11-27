require 'digest/md5'

class Shot < ActiveRecord::Base
  belongs_to :user
  has_many :taggables, dependent: :destroy
  has_many :tags, through: :taggables
  has_many :pins

  validates :url, presence: true
  validates :tag_list, presence: true

  attr_accessor :tag_list
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h

  def fetch_screenshot
    # TODO FetchScreenshotJob.perform_later(url)

    screenshots_dir = File.join(Rails.root, "public", "screenshots")
    filename = File.join(screenshots_dir, "#{md5}.png")

    unless File.exist?(filename)
      Dir.chdir(screenshots_dir) do
        system("pageres #{url} --filename='#{md5}'")
      end
    end
  end

  def crop_screenshot
    # TODO
    path = "/shots/#{SecureRandom.hex(24)}.png"
    screenshots_dir = File.join(Rails.root, "public", "screenshots")
    filename = File.join(screenshots_dir, "#{md5}.png")

    img = MiniMagick::Image.open(filename)
    img.crop "#{crop_w}x#{crop_h}+#{crop_x}+#{crop_y}"
    img.format 'png'
    img.write File.join(Rails.root, "public", path)

    path
  end

  def screenshot_url
    "/screenshots/#{md5}.png"
  end

  def md5
    Digest::MD5.hexdigest(url)
  end
end
