module ApplicationHelper
  def full_title page_title = ""
    base_title = t "base_title"
    if page_title.empty?
      base_title
    else page_title + " | " + base_title
    end
  end

  def training_time object
    start_time = object.start_time.strftime(Settings.format_time)
    end_time = object.end_time.strftime(Settings.format_time)
    return start_time + " - " + end_time
  end

  def get_avatar user
    user.avatar.present? ? user.avatar.url : Settings.default_image
  end
end
