class FetchScreenshotJob < ActiveJob::Base
  queue_as :default

  def perform(url)
    fetcher = Screencap::Fetcher.new(url)
    path = "screenshots/#{fetcher.clean_filename}"

    begin
      Amazon.bucket.find(path)
    rescue S3::Error::NoSuchKey
      file = Amazon.bucket.build(path)
      file.acl = :public_read
      tmp_file = fetcher.fetch
      file.content = tmp_file
      file.save
      FileUtils.rm(tmp_file)
    end
  end
end


