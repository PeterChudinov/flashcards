if ENV['aws_access_key_id'].nil?
  Rails.application.config.paperclip_defaults = { storage: 'file' }
else
  Rails.application.config.paperclip_defaults = {
    storage: 's3',
    s3_region: 'us-west-1',
    s3_host_name: "s3-#{ENV['aws_region']}.amazonaws.com",
    s3_credentials: {
      access_key_id: ENV['aws_access_key_id'],
      secret_access_key: ENV['aws_secret_access_key']
    },
    endpoint: "flashcards-images.s3-#{ENV['aws_region']}.amazonaws.com",
    bucket: 'flashcards-images'
  }
end
