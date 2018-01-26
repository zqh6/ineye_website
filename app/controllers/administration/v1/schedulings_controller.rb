class Administration::V1::SchedulingsController < Administration::V1::PrivilegedController

  def show
  end

  def new
    if params[:function]=='all_user'
      render action: 'new' and return
    end
  end

  def index
  end

end
