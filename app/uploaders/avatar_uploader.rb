class AvatarUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  process :tags => ['post_picture']

  version :standard do
    process :resize_to_fill => [100, 150, :north]
  end

  version :thumbnail do
    resize_to_fit(50, 50)
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
