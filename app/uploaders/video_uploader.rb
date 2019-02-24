class VideoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :fog

  def extension_white_list
    %w(mp4 avi)
  end
end
