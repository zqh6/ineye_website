# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

include RandomUtil

def create_user(phone_number: nil, password: nil)
  ActiveRecord::Base.transaction do
    user = User.phone_number_is(phone_number)
    user = User.new phone_number: phone_number if user.blank?
    user.state     = 'C'
    user.role_code = 'A'
    user.save!
    pepper_content = getRandomStringBy length: 128
    hashed_content = Digest::SHA512.hexdigest password + pepper_content
    password = Password.new user_id: user.id, pepper_content: pepper_content, hashed_content: hashed_content
    password.save!
  end
end

create_user phone_number: '19999999999', password: '123123'
