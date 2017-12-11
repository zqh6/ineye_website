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
