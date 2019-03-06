class Administration::Dosser::V1::NewController < Administration::Dosser::V1::PresentationController

  include ControllerConcerns

  def create
    ActiveRecord::Base.transaction do
      new = New.new new_attributes
      new.user = @login_user
      new.defunct = (params[:defunct]=='true')
      new.classify_tag = ShareEnum.new_classifies[params[:classify].to_sym]
      if new.save
        tags = params[:tags].to_s.strip
        render_conflict message: '标签不要乱输入，Okay?' and return if (/\A(;|；)+\z/.match(tags)).present?
        deal_with_tags tags, new
        render_ok and return
      else
        render_conflict message: error_message(new) and return
      end
    end
  end

  def update
    ActiveRecord::Base.transaction do
      new = New.included_by(params[:id]).first
      render_conflict message: '找不到新闻' and return if new.blank?
      new.assign_attributes new_attributes
      new.defunct = (params[:defunct]=='true')
      new.user = @login_user
      if new.save
        TagRelation.where(relation_type: New.name.underscore).where(relation_id: new.id).delete_all
        tags = params[:tags].to_s.strip
        render_conflict message: '标签不要乱输入，Okay?' and return if (/\A(;|；)+\z/.match(tags)).present?
        deal_with_tags tags, new
        render_ok and return
      else
        render_conflict message: error_message(new) and return
      end
    end
  end

  def destroy
    ActiveRecord::Base.transaction do
      new_one = New.included_by(params[:id]).first
      render_conflict message: '找不到新闻' and return if new_one.blank?
      if new_one.soft_destroy!
        render_ok and return
      else
        render_bad_request and return
      end
    end
  end

  def new_attributes
    params.permit(:title, :vice_title, :occurred_at, :classify, :key_words, :content, :scan_rails_path, :aim_at_platform)
  end

  private :new_attributes

end
