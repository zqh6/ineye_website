class ZtController < ApplicationController
  layout 'zt_header'
  def index

  end
  def sq
    Rails.logger.warn "sq路径"
  end
end
