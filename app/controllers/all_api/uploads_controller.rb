class AllApi::UploadsController < AllApi::PresentationController

  clear_helpers

  include ErrorMessage

  layout :nil

  def create
    collection = []
    if params[:single]!='true'
      params[:files].each do |file|
        path = ''
        if params[:oss]=='true'
          oss_dir  = Yetting.aliyun_oss['aliyun_bucket']+'/'+params[:path].to_s+'/'+Time.new.strftime('%Y_%m')+'/'+SecureRandom.uuid+'/'+file.original_filename
          oss_path = AliyunOss.instance.put(oss_dir, File.open(file.tempfile), {'content_type': file.content_type})
          path = oss_path
          Rails.logger.warn '批量上传OSS成功'
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
          Rails.logger.warn '批量上传本地并复制到手机端成功'
        end
        collection.push({
          path: path,
          name: file.original_filename,
          size: file.size
        })
      end
      Rails.logger.warn collection.inspect
      render json: {success: true, files: collection} and return
    else
      if params[:oss]=='true'
        file = params[:files]
        oss_dir  = Yetting.aliyun_oss['aliyun_bucket']+'/'+params[:path].to_s+'/'+Time.new.strftime('%Y_%m')+'/'+SecureRandom.uuid+'/'+file.original_filename
        Rails.logger.warn file.content_type.inspect
        oss_path = AliyunOss.instance.put(oss_dir, File.open(file.tempfile), {'content_type': file.content_type})
        path = oss_path
        collection.push({
          path: path,
          name: file.original_filename
        })

        Rails.logger.warn '单个上传OSS成功'
        Rails.logger.warn collection.inspect
        render json: {success: true, files: collection} and return
      end
    end
  end
end
