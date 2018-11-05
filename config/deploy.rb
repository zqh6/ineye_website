require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rvm'
require 'mina/unicorn'
#require "mina_sidekiq/tasks"
#require 'mina/whenever'

set :deploy_to, '/data/project/ineye_website'
set :repository, 'git@git.healthsvision.com:hesheng/ineye_website.git'
set :branch, 'master'
#set :forward_agent, false
set :shared_paths, ['config/database.yml', 'config/local_env.yml','config/yetting.yml', 'log', 'tmp', 'tmp/pids/unicorn.pid']
#set :sidekiq_pid, "#{deploy_to}/tmp/pids/sidekiq.pid"
set :unicorn_pid, "#{deploy_to}/tmp/pids/unicorn.pid"

invoke :'rvm:use[ruby-ruby-2.3.3]'
task :environment do
end

task :setup => :environment do
  queue! %[mkdir -p "#{deploy_to}/tmp/sockets/"]
  queue! %[mkdir -p "#{deploy_to}/tmp/pids/"]

  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/uploads/cache/"]
  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/log"]
  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/config"]

  queue! %[touch "#{deploy_to}/#{shared_path}/config/local_env.yml"]
  queue! %[touch "#{deploy_to}/#{shared_path}/config/database.yml"]
  queue! %[touch "#{deploy_to}/#{shared_path}/config/yetting.yml"]
  queue  %[echo "-----> Be sure to edit '#{deploy_to}/#{shared_path}/config/database.yml','local_env.yml'"]

=begin
  queue %[
    repo_host=`echo $repo | sed -e 's/.*@//g' -e 's/:.*//g'` &&
    repo_port=`echo $repo | grep -o ':[0-9]*' | sed -e 's/://g'` &&
    if [ -z "${repo_port}" ]; then repo_port=22; fi ]
=end
end

task :production do
  set :domain, '39.108.7.136'
  set :user, 'deployer'
  set :port, '22'
  set :rvm_path, '/home/deployer/.rvm/bin/rvm'
  set :rails_env, 'production'
  set :unicorn_env, 'production'
end

task :remote_environment do
end

task :setup do
end

desc "Deploys the current version to the server."
task :deploy do
  to :before_hook do
  end
  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'
    to :launch do
      invoke :'unicorn:restart'
    end
  end

end

#  - https://github.com/mina-deploy/mina/tree/master/docs
