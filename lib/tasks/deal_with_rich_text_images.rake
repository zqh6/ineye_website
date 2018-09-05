namespace :deal_with_rich_text_images do

  desc '处理富文本里的图片'
  task do: :environment do
    local_path = Rails.root.to_s+'/public/test/'
    FileUtils.makedirs local_path
    count = 1
    New.all.each do |n|
      content = n.content
      next if content.blank? || content.length<1000
      #content = content.gsub("\\\"", "\"")
      Nokogiri::HTML(content).search('img').each do |imgElement|
        src = imgElement.attr('src')
        next if src.blank? || src.start_with?('http') ||src.length<1000
        src2 = src.sub(/data(.*?)base64,/, '')
        src_first100 = src.first(100)
        content_type = src_first100[5..(src_first100.index(';base64,')-1)]
        image_file_extension = content_type.gsub('image/', '')
        File.open(local_path+count.to_s+'.'+image_file_extension, 'wb') do|f|
          f.write(Base64.decode64(src2))
          oss_dir  = Yetting.aliyun_oss['aliyun_bucket']+'/'+'rich_text'+'/'+(Time.new.to_f*1000000).to_i.to_s+'/'+count.to_s+'.'+image_file_extension
          oss_path = AliyunOss.instance.put(oss_dir, f, {'content_type': content_type})
          content = content.gsub(src, oss_path)
          count+=1
        end
      end
      p content
      n.content = content
      n.save
    end
  end


end
