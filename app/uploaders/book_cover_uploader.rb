# frozen_string_literal: true
class BookCoverUploader < CarrierWave::Uploader::Base
  if Rails.env.production?
    include Cloudinary::CarrierWave

    def public_id
      "book/#{mounted_as}/#{Cloudinary::Utils.random_public_id}"
    end
  else
    include CarrierWave::MiniMagick

    storage :file

    def store_dir
      "uploads/book/#{mounted_as}/#{model.id}"
    end
  end

  process resize_to_fit: [800, 800]

  {
    xxs: [190, 140],
    xs: [150, 190],
    sm: [290, 270],
    md: [350, 400]

  }.each_pair do |key, value|
    version(key) { process resize_to_fit: value }
  end

  def extension_white_list
    %w(jpg jpeg png gif)
  end
end
