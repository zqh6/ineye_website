class KepusController < ApplicationController
  def show
    render layout: "kepu",:action => params[:id]
  end
end
