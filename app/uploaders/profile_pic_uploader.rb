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

  process :resize_to_fill => [600, 600]

  version :thumb do
    process :resize_to_fill => [120, 120]
  end

  version :mini do
    process :resize_to_fill => [60, 60]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def default_url
    asset_path("fallback/profile_default.png")
  end
end
