class ZtController < ApplicationController
  layout 'zt_header'
  def index

  end
  def sq
    Rails.logger.warn 'zt sq 路由日志'
  end
end
