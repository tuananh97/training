module ApplicationHelper
  def page_index params_page, index, per_page
    params_page ||= 1
    (params_page.to_i - 1) * per_page.to_i + index.to_i + 1
  end

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
      option = "{'timeOut': #{5}, 'closeButton': true}" if type == "error"
      text = "toastr.#{type}('#{message}', '', #{option});"
      flash_messages << text if message
    end
    flash_messages.join("\n")
  end

  def training_time object
    start_time = object.start_time.strftime(Settings.format_time)
    end_time = object.end_time.strftime(Settings.format_time)
    start_time + " - " + end_time
  end


  def q_params params
    return params[:name] unless params.nil?
  end

  def get_image course
    course.avatar.present? ? course.avatar.url : Settings.image_course
  end

  def get_avatar user
    if user.avatar.present?
      user.avatar.url
    else
      user.trainee? ? Settings.avatar_trainee : Settings.avatar_teacher
    end
  end
end
