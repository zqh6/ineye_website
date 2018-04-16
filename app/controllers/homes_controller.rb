class HomesController < ApplicationController

  def show
    render layout: "content", :action => params[:id]
  end

  def index
    @new = New.alive.classify_is_not('notice').order('occurred_at DESC').limit(7)
    @new_notice = New.alive.classify_is('notice').order('occurred_at DESC').limit(7)
    @doctors = User.alive.role_code_is('common_user').reorder('user_order DESC')
    render layout: "content", action: :index_backup2 and return
  end

end
