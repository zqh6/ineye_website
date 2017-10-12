#development/test:

##deploy server
####create
INEYE_WEBSITE_DEVELOPMENT_DATABASE_HOST=rds7riznz7riznz.mysql.rds.aliyuncs.com INEYE_WEBSITE_DEVELOPMENT_DATABASE_USERNAME=hesheng INEYE_WEBSITE_DEVELOPMENT_DATABASE_PASSWORD=buvXYxB2uNrAbiGpoZjHXNGPVVEs6mqq rails db:create
####migrate
INEYE_WEBSITE_DEVELOPMENT_DATABASE_HOST=rds7riznz7riznz.mysql.rds.aliyuncs.com INEYE_WEBSITE_DEVELOPMENT_DATABASE_USERNAME=hesheng INEYE_WEBSITE_DEVELOPMENT_DATABASE_PASSWORD=buvXYxB2uNrAbiGpoZjHXNGPVVEs6mqq rails db:migrate
####seed
INEYE_WEBSITE_DEVELOPMENT_DATABASE_HOST=rds7riznz7riznz.mysql.rds.aliyuncs.com INEYE_WEBSITE_DEVELOPMENT_DATABASE_USERNAME=hesheng INEYE_WEBSITE_DEVELOPMENT_DATABASE_PASSWORD=buvXYxB2uNrAbiGpoZjHXNGPVVEs6mqq rails db:seed
####start
INEYE_WEBSITE_DEVELOPMENT_DATABASE_HOST=rds7riznz7riznz.mysql.rds.aliyuncs.com INEYE_WEBSITE_DEVELOPMENT_DATABASE_USERNAME=hesheng INEYE_WEBSITE_DEVELOPMENT_DATABASE_PASSWORD=buvXYxB2uNrAbiGpoZjHXNGPVVEs6mqq unicorn_rails -c /data/project/ineye_website/config/unicorn.rb -E development -D 

##restart server
ps -ef | grep ineye_website

kill -9 xxxx(进程号)

INEYE_WEBSITE_DEVELOPMENT_DATABASE_HOST=rds7riznz7riznz.mysql.rds.aliyuncs.com INEYE_WEBSITE_DEVELOPMENT_DATABASE_USERNAME=hesheng INEYE_WEBSITE_DEVELOPMENT_DATABASE_PASSWORD=buvXYxB2uNrAbiGpoZjHXNGPVVEs6mqq unicorn_rails -c /data/project/ineye_website/config/unicorn.rb -E development -D

#production
暂无
