class AllApi::UploadsController < AllApi::PresentationController

  clear_helpers

  include ErrorMessage

  layout :nil

  def create
    collection = []
    params[:files].each do |file|
      path = ''
      if params[:oss]=='true'
        oss_dir  = 'ineye_website_dev/'+params[:path].to_s+'/'+Time.new.strftime('%Y_%m')+'/'+SecureRandom.uuid+'/'+file.original_filename
        oss_path = AliyunOss.instance.put(oss_dir, File.open(file.tempfile), {'content_type': file.content_type})
        path = oss_path
      elsif params[:local]=='true'
        time_str = Time.new.strftime('%Y_%m')
        uuid = SecureRandom.uuid

        relative_path = '/uploads/'+ params[:path].to_s+'/'+time_str+'/'+uuid
        local_path = Rails.root.to_s+'/public'+relative_path
        FileUtils.makedirs local_path
        local_path = local_path+'/'+file.original_filename
        relative_path = relative_path +'/'+file.original_filename
        FileUtils.cp file.tempfile.path, local_path
        FileUtils.chmod 0777, local_path

        relative_path = '/uploads/'+ params[:path].to_s+'/'+time_str+'/'+uuid
        local_path2 = Yetting.m_ineye_website['rails_root']+'/public'+relative_path
        FileUtils.makedirs local_path2
        local_path2 = local_path2+'/'+file.original_filename
        relative_path = relative_path +'/'+file.original_filename
        FileUtils.cp file.tempfile.path, local_path2
        FileUtils.chmod 0777, local_path2

        path = relative_path
      end
      collection.push({
        path: path,
        name: file.original_filename
      })
    end
    Rails.logger.warn collection.inspect
    render json: {success: true, files: collection} and return
  end
end
