class Administration::V1::NewController < Administration::V1::PrivilegedController

  def show
    @new = New.included_by(params[:id]).first
  end

  def edit
    @new = New.included_by(params[:id]).first
  end

  def new
    @new = New.new occurred_at: DateTime.now, user_id: session[:user_id]
  end

  def index
    @new = New.all
    @new = @new.classify_is(params[:classify]) if params[:classify].present? && params[:classify].to_s!='0'
    @new = @new.title_like(params[:title])     if params[:title].present?
    @new = @new.reorder('created_at DESC')
    @new = @new.paginate(page: params[:page], per_page: 20)
  end

end
