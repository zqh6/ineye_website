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

init_dictionary
create_user phone_number: '19999999999', password_str: '123123'
