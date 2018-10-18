class Supervisor::SubjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_supervisor
  before_action :find_course
  before_action :find_subject, except: [:new, :create, :finish]

  def new
    @subject = @course.subjects.build
    Settings.task_times.times do
      @subject.tasks.build
    end
  end

  def create
    @subject = @course.subjects.build subject_params
    if @subject.save!
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".failure"
    end
    redirect_to supervisor_courses_path
  end

  def show; end

  def edit; end

  def update
    if @subject.update_attributes subject_params
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".failure"
    end
    redirect_to supervisor_course_subject_path
  end

  def destroy
    if @subject.destroy
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".failure"
    end
    redirect_to supervisor_courses_path
  end

  def finish
    @subject = Subject.find_by_id params[:subject_id]

    if @subject.update_attributes status: :finish
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".failure"
    end
    redirect_to supervisor_courses_path
  end

  private

  def subject_params
    params.require(:subject).permit :name, :description, :start_time,
      :end_time, :status, tasks_attributes: [:id, :name, :description,
      :content, :destroy]
  end

  def find_subject
    @subject = Subject.find_by_id params[:id]

    return if @subject
    flash[:danger] = t ".not_found"
    redirect_to supervisor_courses_path
  end

  def find_course
    @course = Course.find_by_id params[:course_id]

    return if @course
    flash[:danger] = t ".not_found"
    redirect_to supervisor_courses_path
  end
end
