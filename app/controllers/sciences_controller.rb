class SciencesController < ApplicationController
  def show
    render layout: "content",:action => params[:id]
  end
end
