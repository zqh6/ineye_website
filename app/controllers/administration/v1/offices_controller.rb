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
    end
    redirect_to administration_v1_office_path(id: @office.id)
  end

  def update
    Rails.logger.warn '111111111111111111'
    @office = Office.find(params[:id])
    @office.name=params[:name]
    @office.vice_name=params[:vice_name]
    @office.save!
    Rails.logger.info @office.inspect
    redirect_to administration_v1_office_path(id: @office.id)
  end

  def new
    @new = Office.new
  end

  def destroy
    @office = Office.find(params[:id])
    @office.soft_destroy!

    redirect_to administration_v1_offices_path
  end


  def index
    @office = Office.alive
    @office = @office.paginate(page: params[:page], per_page: 20)

  end

end
