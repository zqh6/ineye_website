class ConEducationController < ApplicationController
  def show
    logger.info "ConEducationController::show params #{params}"
    render layout: "content",:action => params[:id]
  end
end
