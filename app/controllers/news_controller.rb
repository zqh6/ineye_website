class NewsController < ApplicationController

  layout 'content'

  def show
    render :action => params[:id]
  end

  def new
  end
end
