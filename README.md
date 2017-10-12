#development/test:

##deploy server
####create
RAILS_ENV=development HOST=rds7riznz7riznz.mysql.rds.aliyuncs.com USERNAME=hesheng PASSWORD=buvXYxB2uNrAbiGpoZjHXNGPVVEs6mqq rails db:create
####migrate
RAILS_ENV=development HOST=rds7riznz7riznz.mysql.rds.aliyuncs.com USERNAME=hesheng PASSWORD=buvXYxB2uNrAbiGpoZjHXNGPVVEs6mqq rails db:migrate
####seed
RAILS_ENV=development HOST=rds7riznz7riznz.mysql.rds.aliyuncs.com USERNAME=hesheng PASSWORD=buvXYxB2uNrAbiGpoZjHXNGPVVEs6mqq rails db:seed
####start
RAILS_ENV=development HOST=rds7riznz7riznz.mysql.rds.aliyuncs.com USERNAME=hesheng PASSWORD=buvXYxB2uNrAbiGpoZjHXNGPVVEs6mqq unicorn_rails -c /data/project/ineye_website/config/unicorn.rb -E development -D 

##restart server
ps -ef | grep ineye_website

kill -9 xxxx(进程号)

HOST=rds7riznz7riznz.mysql.rds.aliyuncs.com USERNAME=hesheng PASSWORD=buvXYxB2uNrAbiGpoZjHXNGPVVEs6mqq unicorn_rails -c /data/project/ineye_website/config/unicorn.rb -E development -D

#production

##deploy server
####create
RAILS_ENV=production HOST=rds7riznz7riznz.mysql.rds.aliyuncs.com PASSWORD=buvXYxB2uNrAbiGpoZjHXNGPVVEs6mqq rails db:create
####migrate
RAILS_ENV=production HOST=rds7riznz7riznz.mysql.rds.aliyuncs.com PASSWORD=buvXYxB2uNrAbiGpoZjHXNGPVVEs6mqq rails db:migrate
####seed
RAILS_ENV=production HOST=rds7riznz7riznz.mysql.rds.aliyuncs.com PASSWORD=buvXYxB2uNrAbiGpoZjHXNGPVVEs6mqq rails db:seed
####assets precompile
RAILS_ENV=production HOST=rds7riznz7riznz.mysql.rds.aliyuncs.com PASSWORD=buvXYxB2uNrAbiGpoZjHXNGPVVEs6mqq rails assets:precompile
####start
RAILS_ENV=production HOST=rds7riznz7riznz.mysql.rds.aliyuncs.com PASSWORD=buvXYxB2uNrAbiGpoZjHXNGPVVEs6mqq unicorn_rails -c /data/project/ineye_website/config/unicorn.rb -E production -D

##restart server
ps -ef | grep ineye_website

kill -9 xxxx(进程号)

RAILS_ENV=production HOST=rds7riznz7riznz.mysql.rds.aliyuncs.com PASSWORD=buvXYxB2uNrAbiGpoZjHXNGPVVEs6mqq unicorn_rails -c /data/project/ineye_website/config/unicorn.rb -E production -D
