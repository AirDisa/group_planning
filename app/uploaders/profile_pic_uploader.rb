# encoding: utf-8

class ProfilePicUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include Sprockets::Helpers::RailsHelper
  include Sprockets::Helpers::IsolatedHelper
  permissions 0600

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process :resize_to_fit => [600, 600]

  version :thumb do
    process :resize_to_fit => [64, 64]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def default_url
    asset_path("fallback/profile_default.png")
  end
end
