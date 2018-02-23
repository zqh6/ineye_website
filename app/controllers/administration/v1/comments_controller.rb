class Administration::V1::CommentsController < Administration::V1::PrivilegedController

  def show
    @comment = Comment.included_by(params[:id]).first
  end

  def index
    @comments = Comment.alive
    @comments = @comments.reorder(created_at: :desc)
    @comments = @comments.paginate(page: params[:page], per_page: 20)
  end

end
