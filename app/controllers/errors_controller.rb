class ErrorsController < ApplicationController

  def show
    Rails.logger.warn '404错误：'
    render layout: 'error', action: params[:code].to_s, status: params[:code]
  end

end
