class Administration::Dosser::V1::UsersController < Administration::Dosser::V1::PresentationController

  include RandomUtil

  def index
    if params[:function] == 'users_in_office_time'
=begin
      office_time = OfficeTime.find(params[:office_time_id])
      render_conflict message: 'function参数错误' and return if office_time.blank?
      office_user_relations = OfficeUserRelation.office_id_is(office_time.office_id)
      office_user_relations.each do |office_user_relation|

      end
=end
    elsif params[:function] == 'users_in_office'
      render_conflict message: 'office_id参数错误' and return if params[:office_id].blank?
      user_ids = []
      office_user_relations = OfficeUserRelation.office_id_is(params[:office_id])
      office_user_relations.each do |office_user_relation|
        user_ids.push(office_user_relation.user_id)
      end
      users = User.alive.where('id in (?)', user_ids)
      render_ok collection: users.map{|user| {
        id: user.id,
        name: user.name,
        phone_number: user.phone_number
      }}, size: users.count and return
    end
    render_conflict message: 'function参数错误' and return
  end

  def create
    ActiveRecord::Base.transaction do
      user = User.new user_attributes
      if user.official_account.blank?
        user.official_account = 'no'
      end
      user.create_user = @login_user
      if user.save
        if params[:office_ids].present?
          OfficeUserRelation.alive.user_id_is(user.id).where('office_id in (?)', params[:office_ids]).update_all defunct: true
          params[:office_ids].each do |office_id|
            office_user_relation =OfficeUserRelation.new office_id: office_id, user_id: user.id
            render_conflict message: error_message(office_user_relation) and return unless office_user_relation.save
          end
        end

        pepper_content = getRandomStringBy length: 128
        hashed_content = Digest::SHA512.hexdigest(params[:phone_number][3, 8] + pepper_content)
        password = Password.new user_id: user.id, pepper_content: pepper_content, hashed_content: hashed_content
        if password.save
          TagRelation.tag_name_is(user.name.to_s.strip).update_all tag_flag: 'doctor_name'
          render_ok and return
        else
          render_conflict message: error_message(user) and return
        end
      else
        render_conflict message: error_message(user) and return
      end
    end
  end

  def update
    ActiveRecord::Base.transaction do
      user = User.find(params[:id].to_i)
      render_conflict message: '用户被删除或禁用，无法编辑' if user.defunct==true
      user.assign_attributes user_attributes
      if user.save
        old_office_ids = user.get_offices.collect{|i| i.id}
        new_office_ids = []
        OfficeUserRelation.user_id_is(user.id).delete_all
        if params[:office_ids].present?
          params[:office_ids].each do |office_id|
            office_user_relation =OfficeUserRelation.new office_id: office_id, user_id: user.id
            render_conflict message: error_message(office_user_relation) and return unless office_user_relation.save
            new_office_ids.push(office_id.to_i)
          end
        end
        removed_office_ids = old_office_ids - new_office_ids
        Scheduling.where('office_id in (?)', removed_office_ids).user_id_is(user.id).delete_all
        TagRelation.tag_name_is(user.name.to_s.strip).update_all tag_flag: 'doctor_name'
        render_ok and return
      else
        render_conflict message: error_message(user) and return
      end
    end
  end

  def user_attributes
    params.permit(:name, :phone_number, :role_code, :honour_brief_introduction, :honour_specific, :good_at_field, :work_time, :detailed_introduction, :official_account, :user_order, :doctor_level, :image_url)
  end

  private :user_attributes

end
