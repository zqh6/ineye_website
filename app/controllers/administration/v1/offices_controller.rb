class Administration::V1::OfficesController < Administration::V1::PrivilegedController

  layout 'administration/v1'

  def show
    @office = Office.find(params[:id])
    render :action => 'show'
    # @new = New.included_by(params[:id]).first
  end

  def edit
    @office = Office.find(params[:id])

  end

  def create
    ActiveRecord::Base.transaction do
      @office = Office.new(name: params[:name],vice_name: params[:vice_name])
      @office.save!
      @office_time = OfficeTime.new office_id: @office.id, am_pm_code: 'am'
      @office_time.save!
      @office_time2 = OfficeTime.new office_id: @office.id, am_pm_code: 'pm'
      @office_time2.save!
    end
    redirect_to administration_v1_office_path(id: @office.id)
  end

  def update
    @office = Office.find(params[:id])
    @office.name=params[:name]
    @office.vice_name=params[:vice_name]
    @office.save!
    redirect_to administration_v1_office_path(id: @office.id)
  end

  def new
    @new = Office.new
  end

  def destroy
    @office = Office.find(params[:id])
    @office.soft_destroy!
    OfficeTime.where(office_id: @office.id).each do |office_time|
      office_time.soft_destroy!
    end
    redirect_to administration_v1_offices_path
  end


  def index
    @office = Office.alive
    @office = @office.paginate(page: params[:page], per_page: 20)

  end

end
