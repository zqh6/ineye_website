class NewsController < ApplicationController

  layout 'content'

  def show
<<<<<<< HEAD
    a = params[:id]
    if params[:from]=='db'
      @new = New.find_by_id(params[:id])
      #Rails.logger.warn 'WWWWWWWWWWWWWWWWWWWWWWWWWWW'
      #Rails.logger.warn @new.inspect
      a = 'show'
    end
    render :action => a and return
=======

    render :action => params[:id] and return
>>>>>>> 0e25c580cca7c0f80ec7a61fdac08b54289d053b
  end

  def new
  end

  def index
    if params[:function]=='新闻列表'
      @new = New.order('occurred_at DESC').paginate(page: params[:page], per_page: 15)
      render action: 'list/'+params[:function] and return
    end
  end

end
