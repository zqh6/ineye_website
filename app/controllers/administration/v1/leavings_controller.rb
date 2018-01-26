class Administration::V1::LeavingsController < Administration::V1::PrivilegedController

  def new
    if params[:function]=='all_user'
      render action: 'new' and return
    end
  end

end
