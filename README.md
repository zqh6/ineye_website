#测试服务用production部署

##deploy server
####create
RAILS_ENV=production HOST=rds7riznz7riznz.mysql.rds.aliyuncs.com USERNAME=hesheng PASSWORD=buvXYxB2uNrAbiGpoZjHXNGPVVEs6mqq SECRET_KEY_BASE=00aaeb1a06fcaf7d317b8f59b7710bfec8679825e50ebafcf797bc32af4e60b2b4ee7d070553846d2830153ae2f5e780a36a67c98937298b5f8512669cb86ff5 rails db:create
####migrate
RAILS_ENV=production HOST=rds7riznz7riznz.mysql.rds.aliyuncs.com USERNAME=hesheng PASSWORD=buvXYxB2uNrAbiGpoZjHXNGPVVEs6mqq SECRET_KEY_BASE=00aaeb1a06fcaf7d317b8f59b7710bfec8679825e50ebafcf797bc32af4e60b2b4ee7d070553846d2830153ae2f5e780a36a67c98937298b5f8512669cb86ff5 rails db:migrate
####seed
RAILS_ENV=production  HOST=rds7riznz7riznz.mysql.rds.aliyuncs.com USERNAME=hesheng PASSWORD=buvXYxB2uNrAbiGpoZjHXNGPVVEs6mqq SECRET_KEY_BASE=00aaeb1a06fcaf7d317b8f59b7710bfec8679825e50ebafcf797bc32af4e60b2b4ee7d070553846d2830153ae2f5e780a36a67c98937298b5f8512669cb86ff5 rails db:seed
####assets precompile
RAILS_ENV=production HOST=rds7riznz7riznz.mysql.rds.aliyuncs.com USERNAME=hesheng PASSWORD=buvXYxB2uNrAbiGpoZjHXNGPVVEs6mqq SECRET_KEY_BASE=00aaeb1a06fcaf7d317b8f59b7710bfec8679825e50ebafcf797bc32af4e60b2b4ee7d070553846d2830153ae2f5e780a36a67c98937298b5f8512669cb86ff5 rails assets:precompile
####kind_editor
rails g rails_kindeditor:install
rails kindeditor:assets
####start
HOST=rds7riznz7riznz.mysql.rds.aliyuncs.com USERNAME=hesheng PASSWORD=buvXYxB2uNrAbiGpoZjHXNGPVVEs6mqq SECRET_KEY_BASE=00aaeb1a06fcaf7d317b8f59b7710bfec8679825e50ebafcf797bc32af4e60b2b4ee7d070553846d2830153ae2f5e780a36a67c98937298b5f8512669cb86ff5 unicorn_rails -c /data/project/ineye_website/config/unicorn.rb -E production -D


##restart server
ps -ef | grep ineye_website

kill -9 xxxx(进程号)

RAILS_ENV=production HOST=rds7riznz7riznz.mysql.rds.aliyuncs.com USERNAME=hesheng PASSWORD=buvXYxB2uNrAbiGpoZjHXNGPVVEs6mqq SECRET_KEY_BASE=00aaeb1a06fcaf7d317b8f59b7710bfec8679825e50ebafcf797bc32af4e60b2b4ee7d070553846d2830153ae2f5e780a36a67c98937298b5f8512669cb86ff5 unicorn_rails -c /data/project/ineye_website/config/unicorn.rb -E production -D
=======
#部署需要
##ruby 2.3.3

#本地服务用development部署
##deploy server
####create db
RAILS_ENV=development PASSWORD=libo510723 rails db:create
####migrate db
RAILS_ENV=development PASSWORD=libo510723 rails db:migrate
####seed db
RAILS_ENV=development PASSWORD=libo510723 rails db:seed
####kind_editor
rails g rails_kindeditor:install
rails kindeditor:assets
##start server
/opt/nginx/sbin/nginx -t
/opt/nginx/sbin/nginx
##restart server
/opt/nginx/sbin/nginx -t
/opt/nginx/sbin/nginx -s reload



#正式服务用production部署

##deploy server
####create db
RAILS_ENV=production rails db:create
####migrate db
RAILS_ENV=production rails db:migrate
####seed db
RAILS_ENV=production rails db:seed
>>>>>>> ba939a7b096b383e05503a735ce18be82646ac7b
####assets precompile
RAILS_ENV=production rails assets:precompile
####kind_editor
rails g rails_kindeditor:install
rails kindeditor:assets
####start
出于安全原因，请添加SECRET_KEY_BASE参数
unicorn_rails -c /data/project/ineye_website/config/unicorn.rb -E production -D

##restart server
ps -ef | grep ineye_website

kill -9 xxxx(进程号)

出于安全原因，请添加SECRET_KEY_BASE参数
unicorn_rails -c /data/project/ineye_website/config/unicorn.rb -E production -D

#备用命令
####正式服务器用development时
unicorn_rails -c /data/project/ineye_website/config/unicorn.rb -E development -D
####正式服务器用production时
RAILS_ENV=production rails db:migrate
RAILS_ENV=production rails assets:precompile
SECRET_KEY_BASE=SecureRandom.hex(64) unicorn_rails -c /data/project/ineye_website/config/unicorn.rb -E production -D

