class CropScreenshotJob < ActiveJob::Base
  queue_as :default

  def perform(tmp_path, path, crop_w, crop_h, crop_x, crop_y)
    tmp_file = Amazon.bucket.find(tmp_path)
    file = Amazon.bucket.build(path)

    img = MiniMagick::Image.read(tmp_file.content)

    img.crop "#{crop_w}x#{crop_h}+#{crop_x}+#{crop_y}"
    img.format 'png'
    file.content = img.to_blob
    file.acl = :public_read
    file.save
  end
end

