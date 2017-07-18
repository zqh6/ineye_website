class Administration::Dosser::V1::SessionsController < Administration::Dosser::V1::PresentationController

  def create
    user = User.phone_number_is(params[:phone_number].strip).first
    render_not_found message: '此手机号的用户不存在' and return if user.blank?
    password = user.passwords.alive.first
    this_hashed_content = Digest::SHA512.hexdigest params[:password] + password.pepper_content
    render_conflict message: '密码不正确' and return if this_hashed_content!=password.hashed_content
    session[:user] = user
    render_ok and return
  end

  def destroy
    session[:user] = nil
    render_ok and return
  end

end
