require 's3'

class Amazon
  class << self
    def service
      @service ||= S3::Service.new({
        access_key_id: ENV['AWS_ACCESS_KEY_ID'],
        secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
      })
    end

    def bucket
      @bucket ||= service.buckets.find(ENV['S3_BUCKET']).objects
    end
  end
end
