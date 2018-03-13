class FindPasswordsController < ApplicationController

  layout 'regpwd'

  def edit
    if params[:function] == 'check_phone_number'
      render 'check_phone_number' and return
    elsif params[:function]=='set_new_password'
      #redirect_to edit_find_password_path('~', function: 'check_phone_number') and return if @login_user.blank?
      render 'set_new_password' and return
    elsif params[:function]=='finish'
      render 'finish' and return
    end
  end
end
