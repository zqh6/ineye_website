require 'csv'
class Administration::V1::ActivityEntersController < Administration::V1::PrivilegedController

  def index
    @activity_enters = ActivityEnter.alive.reorder('created_at DESC')
    #@activity_enters = @activity_enters.paginate(page: params[:page], per_page: 20)
    if params[:export_file]=='true'
      csv = CSV.generate do |csv|
        csv << [ (ActivityEnter.human_attribute_name :name), (ActivityEnter.human_attribute_name :phone_number), (ActivityEnter.human_attribute_name :created_at), (ActivityEnter.human_attribute_name :activity_type)]
        @activity_enters.each do |activity_enter|
          row_data =[activity_enter.name, activity_enter.phone_number, activity_enter.created_at_desc, ShareEnum.activity_types[activity_enter.activity_type.to_sym]]
          csv << row_data
        end
      end.encode('gb2312', :invalid => :replace, :undef => :replace, :replace => "?")
      send_data csv, filename: '活动报名'+Time.now.strftime('%Y-%m-%d %H-%M-%S')+'.csv' and return
    end
  end
end
