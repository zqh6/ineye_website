class Administration::Dosser::V1::UsersController < Administration::Dosser::V1::PresentationController

  include RandomUtil

  def create
    ActiveRecord::Base.transaction do
      user = User.new user_attributes
      user.create_user = @login_user
      if user.save
        pepper_content = getRandomStringBy length: 128
        hashed_content = Digest::SHA512.hexdigest(Rails.configuration.default_value[:password] + pepper_content)
        password = Password.new user_id: user.id, pepper_content: pepper_content, hashed_content: hashed_content
        if password.save
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
    params.permit(:name, :phone_number, :role_code)
  end

  def error_message(obj)
    obj.class.human_attribute_name(obj.errors.messages.first[0].to_sym)+obj.errors.messages.first[1].first
  end

  private :user_attributes

end
