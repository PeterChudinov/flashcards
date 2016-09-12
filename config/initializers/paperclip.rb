#TODO: Clean up

if ENV['aws_access_key_id'].nil?
  Rails.application.config.paperclip_defaults = { storage: 'file' }
else
  Paperclip::Attachment.default_options[:storage] = :s3
  Paperclip::Attachment.default_options[:s3_protocol] = 'http'
  Paperclip::Attachment.default_options[:s3_region] = ENV['aws_region']
  Paperclip::Attachment.default_options[:url] = ':s3_domain_url'
  Paperclip::Attachment.default_options[:path] = '/:class/:attachment/:id_partition/:style/:filename'
  Paperclip::Attachment.default_options[:bucket] = 'flashcards-images'
  Paperclip::Attachment.default_options[:s3_host_name] = "s3-#{ENV['aws_region']}.amazonaws.com"
  Paperclip::Attachment.default_options[:s3_credentials] =  {
                                                              :access_key_id => ENV['aws_access_key_id'],
                                                              :secret_access_key => ENV['aws_secret_access_key']
                                                            }
end
