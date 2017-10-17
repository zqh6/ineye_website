# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

include RandomUtil

def init_dictionary
  ActiveRecord::Base.transaction do
    file = File.new(Rails.root.join('lib', 'dictionaries.txt').to_s)
    file.each_line do |line|
      next if line.strip.blank?
      next if line.lstrip.starts_with? '#'
      array = line.chomp.split(',')
      dictionary = Dictionary.included_by(array[0].strip.to_i).first
      dictionary = Dictionary.new if dictionary.blank?
      dictionary.assign_attributes id: array[0].strip.to_i, dictionary_type: array[1].strip, code: array[2].strip, name: array[3].strip, value: array[4].to_i
      dictionary.save
    end
  end
end

def create_user(phone_number: nil, password_str: nil)
  ActiveRecord::Base.transaction do
    user = User.phone_number_is(phone_number).first
    user = User.new phone_number: phone_number if user.blank?
    user.role_code  = ShareEnum.roles.first.first
    user.save!
    user.passwords.alive.each do |oldPassword|
      oldPassword.soft_destroy!
    end
    pepper_content = getRandomStringBy length: 128
    hashed_content = Digest::SHA512.hexdigest password_str + pepper_content
    password = Password.new user_id: user.id, pepper_content: pepper_content, hashed_content: hashed_content
    password.save!
  end
end

#init_dictionary
create_user phone_number: '19999999999', password_str: '123123'

def scan_new
  ActiveRecord::Base.transaction do
    Rails.logger.warn 'Start scan new...'
    all_count =  0
    save_count = 0
    Dir.foreach(Rails.root.join('app', 'views', 'news').to_s) do |folder|
      next if('..'==folder || '.'==folder)
      next if(folder.include? 'DS_Store')
      next if(%w(新闻列表.html.erb index.html.erb edit.html.erb new.html.erb show.html.erb).include? folder)
      Rails.logger.warn folder.inspect
      file_name = folder.gsub('.html.erb', '')
      new = New.find_by_scan_file_id(file_name)
      if new.blank?
        new = New.new scan_file_id: file_name, classify: 'common', scan_rails_path: '/news/'+file_name, title: file_name, user_id: 1
        new.save!
        save_count += 1
      end
      all_count += 1
    end
    Rails.logger.warn 'Finish scan new.'
    Rails.logger.warn 'Scan '+all_count.to_s+' files. Save '+save_count.to_s+' files.'
  end
end

scan_new
