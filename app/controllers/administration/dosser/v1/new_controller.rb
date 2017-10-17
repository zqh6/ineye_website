class Administration::Dosser::V1::NewController < Administration::Dosser::V1::PresentationController

  def create
    ActiveRecord::Base.transaction do
      new = New.new new_attributes
      new.user = @login_user
      if new.save!
        render_ok and return
      else
        Rails.logger.warn new.errors.inspect
        render_bad_request and return
      end
    end
  end

  def update
    ActiveRecord::Base.transaction do
      new = New.included_by(params[:id]).first
      render_conflict message: '找不到新闻' and return if new.blank?
      new.assign_attributes new_attributes
      if new.save!
        render_ok and return
      else
        render_bad_request and return
      end
    end
  end

  def destroy
    ActiveRecord::Base.transaction do
      new = New.included_by(params[:id]).first
      render_conflict message: '找不到新闻' and return if new.blank?
      if new.soft_destroy!
        render_ok and return
      else
        render_bad_request and return
      end
    end
  end

  def new_attributes
    params.permit(:title, :vice_title, :occurred_at, :classify, :key_words, :content, :scan_rails_path, :state)
  end

  private :new_attributes

end
