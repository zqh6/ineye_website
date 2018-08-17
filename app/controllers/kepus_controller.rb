class KepusController < ApplicationController

  layout 'kepu'

  def show
    render :action => params[:id]
  end

  def index
  end
end
