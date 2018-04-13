class NewsController < ApplicationController

  layout 'content'

  def show

    a = params[:id]
    if params[:from]=='db'
      @new = New.find_by_id(params[:id])
      a = 'show'
    end
    render :action => a and return
  end

  def new
  end

  def index
    @newIndex = New.alive.order('occurred_at DESC').limit(15);
    if params[:function]=='新闻列表'
      @new = New.alive.order('occurred_at DESC').paginate(page: params[:page], per_page: 15)
      render action: 'list/'+params[:function] and return
    end
  end

end
