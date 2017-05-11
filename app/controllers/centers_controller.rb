class CentersController < ApplicationController
  def show
    render :action => params[:id]
  end
end
