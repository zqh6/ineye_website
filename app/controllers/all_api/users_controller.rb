class AllApi::UsersController < AllApi::PresentationController

  clear_helpers

  include RandomUtil, ErrorMessage

  layout :nil

  def create
    ActiveRecord::Base.transaction do
      phone_number=params[:phone_number].strip
      render_conflict message: '请填写正确的手机号码' and return if phone_number.blank?
      render_conflict message: '请填写正确的手机号码格式' and return if (/\A1\d{10}\z/.match(phone_number)).blank?
      render_conflict message: '请填写第一个密码' and return if params[:password1].strip.blank?
      render_conflict message: '第一个密码格式不正确' and return if params[:password1].length<6||params[:password1].length>20
      render_conflict message: '请填写第二个密码' and return if params[:password2].strip.blank?
      render_conflict message: '第二个密码格式不正确' and return if params[:password2].length<6||params[:password2].length>20
      render_conflict message: '两个密码不一致' and return if params[:password1].strip != params[:password2].strip
      render_conflict message: '请填写您的姓名' and return if params[:name].blank?
      render_conflict message: '请填写医院名称' and return if params[:unit_name].blank?
      #验证手机、手机验证码
      validate_code = ValidateCode.find_by_phone_number(phone_number)
      render_conflict message: '没有验证码' and return if validate_code.blank?
      render_conflict message: '手机号和验证码不对应' and return if validate_code.phone_number != phone_number
      render_conflict message: '验证码不正确' and return if validate_code.validate_code!=params[:validate_code].strip
      render_conflict message: '验证码已失效' and return if validate_code.opened_at>Time.new || validate_code.closed_at<Time.new
      user = User.new role_code: 'outer_user', official_account: 'no', name: params[:name].strip, unit_name: params[:unit_name], phone_number: phone_number
      if user.save
        pepper_content = getRandomStringBy length: 128
        hashed_content = Digest::SHA512.hexdigest(params[:password1].strip + pepper_content)
        password = Password.new user_id: user.id, pepper_content: pepper_content, hashed_content: hashed_content
        if password.save
          #清除手机验证码
          validate_code.validate_code=nil
          validate_code.save!
          render_ok and return
        else
          render_conflict message: error_message(user) and return
        end
      else
        render_conflict message: error_message(user) and return
      end
    end
  end

  def user_attributes
    params.permit(:name, :unit_name, :phone_number, :validate_code, :password1, :password2)
  end

end
