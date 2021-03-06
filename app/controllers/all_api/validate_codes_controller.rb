class AllApi::ValidateCodesController < AllApi::PresentationController

  clear_helpers

  include RandomUtil, ErrorMessage

  layout :nil

  def create
    ActiveRecord::Base.transaction do
      render_conflict message: '手机格式不正确' and return if (/\A1\d{10}\z/.match(params[:phone_number])).blank?
      phone_number = params[:phone_number].strip
      if 'find_password'==params[:function]
        render_conflict message: '账号信息异常，请联系管理员' and return if User.find_by_phone_number(phone_number).blank?
      end
      now = Time.new
      validate_code = ValidateCode.find_by_phone_number(phone_number)
      new_flag = false
      if validate_code.blank?
        new_flag = true
        validate_code = ValidateCode.new phone_number: phone_number
      else
        if validate_code.opened_at<=now && validate_code.closed_at>=now && validate_code.validate_code.present?
          #用旧的validate_code且不做变更
          new_flag = false
        else
          #用新的validate_code且指定有效时间范围
          new_flag = true
        end
      end
      if new_flag
        code = getRandomIntStringBy length: 4
        validate_code.assign_attributes validate_code: code, opened_at: Time.new, closed_at: (Time.new+Rails.configuration.time_to_lives[:validate_code_second].seconds)
        if validate_code.save
          ChinaSMS.use :smsbao, username: Yetting.sms["user_name"], password: Yetting.sms["password"]
          min_count = (Rails.configuration.time_to_lives[:validate_code_second]/60).to_s
          sms_result = ChinaSMS.to phone_number, "您的验证码为#{code},在#{min_count}分钟内有效【中医大银海眼科医院】"
          Rails.logger.warn sms_result.inspect
        else
          render_conflict message: error_message(validate_code) and return
        end
      end
      if 'find_password'==params[:function]
        session[:phone_number] = phone_number
      end
      code = validate_code.validate_code
      render_ok collection: [{validate_code: validate_code.validate_code}] and return
    end
  end

  def update
    ActiveRecord::Base.transaction do
      phone_number = params[:phone_number].to_s.strip
      render_conflict message: '手机号码不正确' and return if (/\A1\d{10}\z/.match(params[:phone_number])).blank?
      code = params[:validate_code].to_s.strip
      render_conflict message: '验证码不正确' and return if (/\A\d{4}\z/.match(params[:validate_code])).blank?
      validate_code = ValidateCode.find_by_phone_number(phone_number)
      if validate_code.validate_code == code
        validate_code.validate_code=nil
        validate_code.save!
        render_ok and return
      else
        render_conflict message: '验证码不正确' and return
      end

    end
  end

  def index
    phone_number = params[:phone_number].to_s.strip
    render_conflict message: '手机号码不正确' and return if (/\A1\d{10}\z/.match(params[:phone_number])).blank?
    code = params[:validate_code].to_s.strip
    render_conflict message: '验证码格式不正确' and return if (/\A\d{4}\z/.match(params[:validate_code])).blank?
    validate_code = ValidateCode.find_by_phone_number(phone_number)
    render_ok code: '0', message: '验证不通过' and return if validate_code.blank? || validate_code.opened_at>Time.new || validate_code.closed_at<Time.new
    if validate_code.validate_code == code
      render_ok code: '1', message: '验证通过' and return
    else
      render_ok code: '0', message: '验证不通过' and return
    end
  end

end
