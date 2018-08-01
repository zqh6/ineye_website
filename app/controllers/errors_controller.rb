class ErrorsController < ApplicationController

  def show
    Rails.logger.warn '111111111111'
    render layout: 'error', action: params[:code].to_s, status: params[:code]
  end

end
