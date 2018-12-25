module ApplicationHelper
  def full_title page_title = ""
    base_title = t "base_title"
    if page_title.empty?
      base_title
    else page_title + " | " + base_title
    end
  end

  def check_status_task user_id, task_id
    @trainee_task = TraineeTask.find_trainee_task(user_id, task_id)
  end

  def custom_bootstrap_flash
    flash_messages = []
    option = "{'closeButton': true}"
    flash.each do |type, message|
      type = "success" if type == "notice"
      type = "error" if type == "alert"
      type = "warning" if type == "warning"
      text = "toastr.#{type}('#{message}');"
      flash_messages << text if message
    end
    flash_messages.join("\n")
  end

  def training_time object
    start_time = object.start_time.strftime(Settings.format_time)
    end_time = object.end_time.strftime(Settings.format_time)
    return start_time + " - " + end_time
  end

  def get_avatar user
    if user.avatar.present?
      user.avatar.url
    else
      user.trainee? ? Settings.default_avatar_trainee : Settings.default_avatar_teacher
    end
  end
end
