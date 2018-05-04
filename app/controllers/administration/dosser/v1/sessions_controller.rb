class Administration::Dosser::V1::SessionsController < Administration::Dosser::V1::PresentationController

  def create
    render_conflict message: '请填写正确的手机号' and return if params[:phone_number].strip.blank?
    render_conflict message: '请填写密码' and return if params[:password].strip.blank?
    user = User.phone_number_is(params[:phone_number].strip).first
    render_conflict message: '此手机号的用户不存在' and return if user.blank?
    password = user.passwords.alive.first
    this_hashed_content = Digest::SHA512.hexdigest params[:password] + password.pepper_content
    render_conflict message: '密码不正确' and return if this_hashed_content!=password.hashed_content
    session[:user_id] = user.id
    render_ok and return
  end

  def destroy
    session[:user_id] = nil
    render_ok and return
  end

end
