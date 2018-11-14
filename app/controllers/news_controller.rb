class NewsController < ApplicationController

  layout 'content'

  def show
    if params[:from]=='db'
      @new = New.find_by_id(params[:id])
      a = 'show'
    else
      @new = New.scan_rails_path_is(URI.decode(request.fullpath)).first
      a = params[:id]
    end

    #read count
    @new.read_count = @new.read_count.to_i+1
    @new.save!

    tag_names = TagRelation.alive.relation_id_is(@new.id).collect{|i| i.tag_name}
    new_ids = TagRelation.alive.relation_type_is(New.name.underscore).where('tag_name in (?)', tag_names).collect{|i| i.relation_id.to_i}.uniq
    if new_ids.present?
      new_ids = new_ids - [@new.id]
    else
      new_ids = []
    end
    #相关阅读
    @relation_news = New.alive.classify_is_not('notice').where('aim_at_platform in (?)', ['pc', 'pc_and_mobile']).where('id in (?)', new_ids).reorder('occurred_at DESC')
    #上一篇
    remain_new_ids = New.alive.collect{|n| n.id}-[@new.id]
    last_new_id = remain_new_ids.sample
    @last_new = New.find_by_id(last_new_id)
    #下一篇
    remain_new_ids = remain_new_ids-[last_new_id]
    next_new_id = remain_new_ids.sample
    @next_new = New.find_by_id(next_new_id)

    render :action => a and return
  end

  def new
  end

  def index
    @newIndex = New.alive.classify_is_not('notice').where('aim_at_platform in (?)', ['pc', 'pc_and_mobile']).order('occurred_at DESC').limit(15);
    if params[:function]=='新闻列表'
      @new = New.alive.reorder('occurred_at DESC').paginate(page: params[:page], per_page: 15)
      render action: 'list/'+params[:function] and return
    end
  end

end
