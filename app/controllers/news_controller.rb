class NewsController < ApplicationController

  layout 'content'

  def show

    render :action => params[:id] and return
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
