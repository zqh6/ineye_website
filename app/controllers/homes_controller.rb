class HomesController < ApplicationController



  def show
    render layout: "content", :action => params[:id]
  end

  def index
    render layout: "content"
  end
end
