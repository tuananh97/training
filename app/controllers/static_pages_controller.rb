class StaticPagesController < ApplicationController
  def welcome
    @courses = Course.all.page(params[:page]).per Settings.per_page
  end
end
