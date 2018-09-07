class HomesController < ApplicationController

  def show
    render layout: "content", :action => params[:id]
  end

  def index
    @new = New.alive.where('aim_at_platform in (?)', ['pc', 'pc_and_mobile']).classify_is_not('notice').order('occurred_at DESC').limit(7)
    @new_notice = New.alive.where('aim_at_platform in (?)', ['pc', 'pc_and_mobile']).classify_is('notice').order('occurred_at DESC').limit(7)
    @doctors = User.alive.role_code_is('common_user').reorder('user_order DESC')
    @banners = Banner.state_alive2.where('aim_at_platform in (?)', ['pc', 'pc_and_mobile']).reorder('serial asc, created_at desc')

    render layout: "content", action: :index and return
  end

end
