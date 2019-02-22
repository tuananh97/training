class StaticPagesController < ApplicationController
  def welcome
    @q = Course.ransack params[:q]
    @courses = @q.result(distinct: true).page(params[:page]).per 4
  end
end
