module TraineeSubjectsHelper
  def check_status_subject user_id, subject_id
    @trainee_subject = TraineeSubject.find_trainee_subject(user_id, subject_id)
  end
end
