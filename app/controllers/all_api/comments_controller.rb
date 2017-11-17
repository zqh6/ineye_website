class AllApi::CommentsController < AllApi::PresentationController

  clear_helpers

  include Repres::Dosser::Concerns::ResourcePresentation

  layout :nil

  before_action :validate_login, only: [:create, :update, :destory]

  def validate_login
    @login_user = User.included_by(session[:user]['id']).first if session[:user].present?
  end

  def create
    ActiveRecord::Base.transaction do
      comment = Comment.new attribute_fields
      if Comment.find_by_id(params[:comment][:parent_id]).blank?
        render_conflict message: '没有指定的上级评论' and return
      end
      comment.creator_id = @login_user.id if @login_user.present?
      if comment.save
        render_ok message: '评论成功', collection: [{
          comment_id: comment.id
        }] and return
      else
        render_conflict message: '评论失败' and return
      end
    end
  end

  def update
    ActiveRecord::Base.transaction do
      comment = Comment.find_by_id(params[:id])
      if comment.blank?
        render_conflict message: '没有此评论数据' and return
      end
      comment.assign_attributes auditor_id: params[:auditor_id], state: params[:state]
      if comment.save
        render_ok and return
      else
        render_conflict message: '修改评论失败' and return
      end
    end
  end

  def destroy
  end

  def show
    comments = Comment.where('parent_id is null')
    comments = comments.post_id_is(params[:post_id].strip.to_i) if params[:post_id].present?
    comments = comments.post_link_is(params[:post_link].strip) if comments.blank? && params[:post_link].present?
    if comments.blank?
      render_conflict message: '没有顶级评论数据' and return
    end
    collection = []
    comments.each do |top_comment|
      top_comment_json = top_comment.to_json_by(fields: [:id, :content, :created_at])
      top_comment_json[:sons]    = get_later_generations(top_comment)
      collection.push(top_comment_json)
    end
    render_ok message: '获取帖子评论成功', collection: collection and return
  end

  def get_later_generations(top_comment)
    tmp_collection = []
    if top_comment.present?
      comments = Comment.parent_id_is(top_comment.id)
      if comments.present?
        comments.each do |comment|
          comment_json = comment.to_json_by(fields: [:id, :content, :created_at])
          comment_json[:sons]    = get_later_generations(comment)
          tmp_collection.push(comment_json)
        end
      end
    end
    tmp_collection
  end

  def attribute_fields
    params.require(:comment).permit(:parent_id, :content, :post_link, :post_id)
  end

  private :attribute_fields

end
