class AllApi::UploadsController < AllApi::PresentationController

  clear_helpers

  include ErrorMessage

  layout :nil

  def create
    collection = []
    params[:files].each do |file|
      oss_dir  = 'ineye_website_dev/'+params[:path].to_s+'/'+Time.new.strftime('%Y_%m')+'/'+SecureRandom.uuid+'/'+file.original_filename
      oss_path = AliyunOss.instance.put(oss_dir, File.open(file.tempfile), {'content_type': file.content_type})
      collection.push({
        path: oss_path,
        name: file.original_filename
      })
    end
    Rails.logger.warn collection.inspect
    render json: {success: true, files: collection} and return
  end
end
