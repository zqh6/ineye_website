module Rails
  class << self
    def root
      File.expand_path("../..", __FILE__)
    end
  end
end
# Application root dir
APP_HOME = Rails.root

# Help ensure your application will always spawn in the symlinked
# "current" directory that Capistrano sets up.
working_directory APP_HOME # available in 0.94.0+

if 'production' == ENV['RAILS_ENV']
  listen "/data/project/ineye_website/tmp/sockets/unicorn.sock", :backlog => 64
  pid "/data/project/zyd_meeting/tmp/pids/unicorn.pid"
  worker_processes 2
else
  worker_processes 1
  listen 3001, :tcp_nopush => true
  pid "#{APP_HOME}/tmp/pids/unicorn.pid"
end

# nuke workers after 30 seconds instead of 60 seconds (the default)
timeout 60

stderr_path "#{APP_HOME}/log/unicorn.stderr.log"
stdout_path "#{APP_HOME}/log/unicorn.stdout.log"

# combine Ruby 2.0.0dev or REE with "preload_app true" for memory savings
# http://rubyenterpriseedition.com/faq.html#adapt_apps_for_cow
preload_app true

if GC.respond_to?(:copy_on_write_friendly=)
  GC.copy_on_write_friendly = true
end

check_client_connection false

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!

  old_pid = "#{APP_HOME}/tmp/pids/unicorn.pid.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      puts "Send 'QUIT' signal to unicorn error!"
    end
  end
end

after_fork do |server, worker|
  # the following is *required* for Rails + "preload_app true",
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end
