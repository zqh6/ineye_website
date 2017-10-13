#测试服务用production部署

##deploy server
####create
RAILS_ENV=production HOST=rds7riznz7riznz.mysql.rds.aliyuncs.com USERNAME=hesheng PASSWORD=buvXYxB2uNrAbiGpoZjHXNGPVVEs6mqq rails db:create
####migrate
RAILS_ENV=production HOST=rds7riznz7riznz.mysql.rds.aliyuncs.com USERNAME=hesheng PASSWORD=buvXYxB2uNrAbiGpoZjHXNGPVVEs6mqq rails db:migrate
####seed
RAILS_ENV=production HOST=rds7riznz7riznz.mysql.rds.aliyuncs.com USERNAME=hesheng PASSWORD=buvXYxB2uNrAbiGpoZjHXNGPVVEs6mqq rails db:seed
####kind_editor
rails g rails_kindeditor:install
rails kindeditor:assets
####start
RAILS_ENV=production HOST=rds7riznz7riznz.mysql.rds.aliyuncs.com USERNAME=hesheng PASSWORD=buvXYxB2uNrAbiGpoZjHXNGPVVEs6mqq unicorn_rails -c /data/project/ineye_website/config/unicorn.rb -E production -D 


##restart server
ps -ef | grep ineye_website

kill -9 xxxx(进程号)

RAILS_ENV=production HOST=rds7riznz7riznz.mysql.rds.aliyuncs.com USERNAME=hesheng PASSWORD=buvXYxB2uNrAbiGpoZjHXNGPVVEs6mqq unicorn_rails -c /data/project/ineye_website/config/unicorn.rb -E production -D

#正式服务用production部署

##deploy server
####create
RAILS_ENV=production DATABASE=ineye_website_prd HOST=rds7riznz7riznz.mysql.rds.aliyuncs.com PASSWORD=buvXYxB2uNrAbiGpoZjHXNGPVVEs6mqq rails db:create
####migrate
RAILS_ENV=production DATABASE=ineye_website_prd HOST=rds7riznz7riznz.mysql.rds.aliyuncs.com PASSWORD=buvXYxB2uNrAbiGpoZjHXNGPVVEs6mqq rails db:migrate
####seed
RAILS_ENV=production DATABASE=ineye_website_prd HOST=rds7riznz7riznz.mysql.rds.aliyuncs.com PASSWORD=buvXYxB2uNrAbiGpoZjHXNGPVVEs6mqq rails db:seed
####assets precompile
RAILS_ENV=production DATABASE=ineye_website_prd HOST=rds7riznz7riznz.mysql.rds.aliyuncs.com PASSWORD=buvXYxB2uNrAbiGpoZjHXNGPVVEs6mqq rails assets:precompile
####kind_editor
rails g rails_kindeditor:install
rails kindeditor:assets
####start
RAILS_ENV=production DATABASE=ineye_website_prd HOST=rds7riznz7riznz.mysql.rds.aliyuncs.com PASSWORD=buvXYxB2uNrAbiGpoZjHXNGPVVEs6mqq unicorn_rails -c /data/project/ineye_website/config/unicorn.rb -E production -D

##restart server
ps -ef | grep ineye_website

kill -9 xxxx(进程号)

RAILS_ENV=production DATABASE=ineye_website_prd HOST=rds7riznz7riznz.mysql.rds.aliyuncs.com PASSWORD=buvXYxB2uNrAbiGpoZjHXNGPVVEs6mqq unicorn_rails -c /data/project/ineye_website/config/unicorn.rb -E production -D
