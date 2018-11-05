require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rvm'
require 'mina/unicorn'
#require "mina_sidekiq/tasks"
#require 'mina/whenever'
# require 'mina/rbenv'  # for rbenv support. (https://rbenv.org)
# require 'mina/rvm'    # for rvm support. (https://rvm.io)

# Basic settings:
#   domain       - The hostname to SSH to.
#   deploy_to    - Path to deploy into.
#   repository   - Git repo to clone from. (needed by mina/git)
#   branch       - Branch name to deploy. (needed by mina/git)
set :deploy_to, '/data/project/ineye_website'
set :repository, 'git@git.healthsvision.com:hesheng/ineye_website.git'
set :branch, 'master'
#set :forward_agent, false
set :shared_paths, ['config/database.yml', 'config/yetting.yml','config/symmetric-encryption.yml','log']
#set :sidekiq_pid, "#{deploy_to}/tmp/pids/sidekiq.pid"
set :unicorn_pid, "#{deploy_to}/tmp/pids/unicorn.pid"

task :environment do
  invoke :'rvm:use[ruby-ruby-2.3.0]'
end

task :setup => :environment do
  # unicorn and sidekiq needs a place to store its pid file
  queue! %[mkdir -p "#{deploy_to}/tmp/sockets/"]
  queue! %[mkdir -p "#{deploy_to}/tmp/pids/"]

  #fileupload tmp file
  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/uploads/cache/"]

  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/log"]
  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/config"]

  queue! %[touch "#{deploy_to}/#{shared_path}/config/local_env.yml"]
  queue! %[touch "#{deploy_to}/#{shared_path}/config/database.yml"]
  queue! %[touch "#{deploy_to}/#{shared_path}/config/yetting.yml"]
  queue  %[echo "-----> Be sure to edit '#{deploy_to}/#{shared_path}/config/database.yml','local_env.yml'"]

  queue %[
    repo_host=`echo $repo | sed -e 's/.*@//g' -e 's/:.*//g'` &&
    repo_port=`echo $repo | grep -o ':[0-9]*' | sed -e 's/://g'` &&
    if [ -z "${repo_port}" ]; then repo_port=22; fi ]
end

task :production do
  set :domain, '39.108.7.136'
  set :user, 'deployer'
  set :port, '22'
  set :rvm_path, '/home/deployer/.rvm/bin/rvm'
  set :rails_env, 'production'
  set :unicorn_env, 'production'
end

# Optional settings:
#   set :user, 'foobar'          # Username in the server to SSH to.
#   set :port, '30000'           # SSH port number.
#   set :forward_agent, true     # SSH forward_agent.

# Shared dirs and files will be symlinked into the app-folder by the 'deploy:link_shared_paths' step.
# Some plugins already add folders to shared_dirs like `mina/rails` add `public/assets`, `vendor/bundle` and many more
# run `mina -d` to see all folders and files already included in `shared_dirs` and `shared_files`
# set :shared_dirs, fetch(:shared_dirs, []).push('public/assets')
# set :shared_files, fetch(:shared_files, []).push('config/database.yml', 'config/secrets.yml')

# This task is the environment that is loaded for all remote run commands, such as
# `mina deploy` or `mina rake`.
task :remote_environment do
  # If you're using rbenv, use this to load the rbenv environment.
  # Be sure to commit your .ruby-version or .rbenv-version to your repository.
  # invoke :'rbenv:load'

  # For those using RVM, use this to load an RVM version@gemset.
  # invoke :'rvm:use', 'ruby-1.9.3-p125@default'
end

# Put any custom commands you need to run at setup
# All paths in `shared_dirs` and `shared_paths` will be created on their own.
task :setup do
  # command %{rbenv install 2.3.0 --skip-existing}
end

desc "Deploys the current version to the server."
task :deploy do
  to :before_hook do
    # Put things to run locally before ssh
  end
  # uncomment this line to make sure you pushed your local branch to the remote origin
  # invoke :'git:ensure_pushed'
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    on :launch do
      invoke :'unicorn:restart'
      # in_path(fetch(:current_path)) do
      #   command %{mkdir -p tmp/}
      #   command %{touch tmp/restart.txt}
      # end
    end
  end

  # you can use `run :local` to run tasks on local machine before of after the deploy scripts
  # run(:local){ say 'done' }
end

# For help in making your deploy script, see the Mina documentation:
#
#  - https://github.com/mina-deploy/mina/tree/master/docs
