class CropScreenshotJob < ActiveJob::Base
  queue_as :default

  def perform(tmp_path, path, crop_w, crop_h, crop_x, crop_y)
    # TODO
  end
end

