class FetchScreenshotJob < ActiveJob::Base
  queue_as :default

  def perform(url)
    # TODO
  end
end
