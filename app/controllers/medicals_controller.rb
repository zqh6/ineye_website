class MedicalsController < ApplicationController
  def show

    @all_scheduling = {}
    one_office_scheduling = {}

    office_ids = []
    office_hash = {}

    user_ids = []
    user_hash = {}
    Scheduling.alive.each do |scheduling|
      if office_ids.include?(scheduling.office_id)
        office_name = office_hash[scheduling.office_id.to_s.to_sym]
      else
        office_name = Office.find(scheduling.office_id).name
        office_ids.push(scheduling.office_id)
        office_hash[scheduling.office_id.to_s.to_sym] = office_name
      end

      @all_scheduling[scheduling.office_id.to_s.to_sym] = {} if @all_scheduling[scheduling.office_id.to_s.to_sym].blank?
      @all_scheduling[scheduling.office_id.to_s.to_sym][:office_name] = office_name

      @all_scheduling[scheduling.office_id.to_s.to_sym][scheduling.am_pm_code.to_s.to_sym] = {} if @all_scheduling[scheduling.office_id.to_s.to_sym][scheduling.am_pm_code.to_s.to_sym].blank?
      @all_scheduling[scheduling.office_id.to_s.to_sym][scheduling.am_pm_code.to_s.to_sym][scheduling.week_code.to_s.to_sym] = [] if @all_scheduling[scheduling.office_id.to_s.to_sym][scheduling.am_pm_code.to_s.to_sym][scheduling.week_code.to_s.to_sym].blank?

      today_scheduling_info = {}
      today_scheduling_info[:outpatient_service_type] = scheduling.outpatient_service_type
      today_scheduling_info[:outpatient_service_type_desc] = ShareEnum.outpatient_services[scheduling.outpatient_service_type.to_s.to_sym]
      today_scheduling_info[:user_id] = scheduling.user_id
      if user_ids.include?(scheduling.user_id)
        user_name = user_hash[scheduling.user_id.to_s.to_sym]
      else
        user = User.find(scheduling.user_id)
        next if user.defunct==true
        user_name = user.name
        user_ids.push(scheduling.user_id)
        user_hash[scheduling.user_id.to_s.to_sym] = user_name
      end
      today_scheduling_info[:user_name] = user_name

      @all_scheduling[scheduling.office_id.to_s.to_sym][scheduling.am_pm_code.to_s.to_sym][scheduling.week_code.to_s.to_sym].push(today_scheduling_info)
    end
    render layout: "content", :action => params[:id]
  end
  def index
    render '专家排班'
  end
end
