class NewsController < ApplicationController

  layout 'content'

  def show
    if params[:id]=='新闻列表'
      @new = New.paginate(page: params[:page], per_page: 15)
    end
    render :action => params[:id] and return
  end

  def new
  end

  def index
    if params[:function]=='新闻列表'
      @new = New.paginate(page: params[:page], per_page: 15)
      render action: 'list/'+params[:function] and return
    end
  end

end
