class VideoUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  process :tags => ['post_video']

  def extension_white_list
    %w(mp4 avi)
  end
end
