class Administration::V1::PasswordsController < Administration::V1::PrivilegedController

  include RandomUtil

  def edit
  end

  def update
    user = User.included_by(session[:user]['id']).first
    redirect_to edit_administration_v1_password_path('~') and flash[:error]='新密码格式不正确' and return if params[:new_password].include?(' ') || params[:new_password2].include?(' ')
    redirect_to edit_administration_v1_password_path('~') and flash[:error]='新密码不能为空' and return if params[:new_password].blank? || params[:new_password2].blank?
    redirect_to edit_administration_v1_password_path('~') and flash[:error]='两次新密码不一样' and return if params[:new_password] != params[:new_password2]
    password = user.passwords.alive.first
    this_hashed_content = Digest::SHA512.hexdigest params[:old_password] + password.pepper_content
    redirect_to edit_administration_v1_password_path('~') and flash[:error]='旧密码不正确' and return if password.hashed_content != this_hashed_content
    ActiveRecord::Base.transaction do
      password.closed_at = Time.now
      password.defunct = true
      password.save!
      pepper_content = getRandomStringBy(length: 128)
      new_hashed_content = Digest::SHA512.hexdigest params[:new_password] + pepper_content
      new_password = Password.new user: user, pepper_content: pepper_content, hashed_content: new_hashed_content
      new_password.save!
    end
    render 'success' and return
  end

end
