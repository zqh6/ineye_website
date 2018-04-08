class AllApi::SessionsController < AllApi::PresentationController

  clear_helpers

  layout :nil

  def show
    if session[:user_id].present?
      render_ok and return
    else
      render_conflict message: '请登录后再操作' and return
    end
  end
end
