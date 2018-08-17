class SciencesController < ApplicationController
  def show
    render layout: "content",:action => params[:id]
  end
  def index
    render '学院简介'
  end
end
