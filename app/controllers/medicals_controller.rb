class MedicalsController < ApplicationController
  def show
    render layout: "content",:action => params[:id]
  end
  def index
    render '专家排班'
  end
end
