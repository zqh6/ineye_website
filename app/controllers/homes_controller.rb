class HomesController < ApplicationController



  def show
    render layout: "content", :action => params[:id]
  end

  def index
    @new = New.alive.order('occurred_at DESC').limit(6);
    render layout: "content"
  end
end
