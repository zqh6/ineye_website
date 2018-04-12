class HomesController < ApplicationController

  def show
    render layout: "content", :action => params[:id]
  end

  def index
    @new = New.alive.order('occurred_at DESC').limit(7);
    @doctors = User.alive.role_code_is('common_user')
    render layout: "content" and return
  end

end
