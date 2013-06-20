# encoding: utf-8
class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include Sprockets::Helpers::RailsHelper
  include Sprockets::Helpers::IsolatedHelper
  permissions 0600

  Rails.env.production? ? storage(:fog) : storage(:file)

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process :resize_to_fit => [450, 450]

  version :thumb do
    process :resize_to_fit => [48, 48]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

end
