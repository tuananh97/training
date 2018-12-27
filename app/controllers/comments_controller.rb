class CommentsController < HomePagesController
  before_action :load_comment, except: %i(index new create)

  def new; end

  def create
    @comment = current_user.comments.build comment_params
    return if @comment.save!
    respond_to do |format|
      format.html{redirect_to @comment.task}
      format.js
    end
  end

  def edit
    respond_to do |format|
      format.html{redirect_to @comment.task}
      format.js
    end
  end

  def update
    if @comment.update_attributes comment_params
      respond_to do |format|
        format.html{redirect_to @comment.task}
        format.js
      end
    else
      flash[:error] = t ".danger"
      render :edit
    end
  end

  def destroy
    return if @comment.destroy
    respond_to do |format|
      format.html{redirect_to @comment.task}
      format.js
    end
  end

  def new_reply
    respond_to do |format|
      format.html{redirect_to @comment.task}
      format.js
    end
  end

  private

  def comment_params
    params.require(:comment).permit :content, :task_id, :user_id, :parent_id
  end

  def load_comment
    @comment = Comment.find_by id: params[:id]
    return if @comment
    flash[:error] = t ".danger"
    redirect_back fallback_location: root_path
  end
end
