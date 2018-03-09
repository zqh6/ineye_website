class AllApi::FindPasswordsController < AllApi::PresentationController

  clear_helpers

  include ErrorMessage, RandomUtil

  layout :nil

  def update
    render_conflict message: '用户未登录' and return if @login_user.blank?
    render_conflict message: '请填写第一个密码' and return if params[:password1].strip.blank?
    render_conflict message: '第一个密码格式不正确' and return if (/\A(?![\d]+$)(?![a-zA-Z]+$)(?![^\da-zA-Z]+$).{6,20}\z/.match(params[:password1])).blank?
    render_conflict message: '请填写第二个密码' and return if params[:password2].strip.blank?
    render_conflict message: '第二个密码格式不正确' and return if (/\A(?![\d]+$)(?![a-zA-Z]+$)(?![^\da-zA-Z]+$).{6,20}\z/.match(params[:password2])).blank?
    render_conflict message: '两个密码不一致' and return if params[:password1].strip != params[:password2].strip
    Password.alive.where(user_id: @login_user.id).update_all defunct: true
    pepper_content = getRandomStringBy length: 128
    hashed_content = Digest::SHA512.hexdigest(params[:password1].strip + pepper_content)
    password = Password.new user_id: @login_user.id, pepper_content: pepper_content, hashed_content: hashed_content
    if password.save
      render_ok and return
    else
      render_conflict message: error_message(password) and return
    end
  end
end
