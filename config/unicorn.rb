# Limited to 512mb on Heroku. Current app footprint ~130mb
worker_processes 3

# Load app into the master before forking workers for faster spawn times
preload_app true

# Restart workers when request exceeds timeout
timeout 30


# Properly setup and teardown connections for preload_app true

before_fork do |server, worker|
  ActiveRecord::Base.connection.disconnect! if defined?(ActiveRecord::Base)
  EM.stop if defined?(EM) && EM.reactor_running?
end

after_fork do |server, worker|
  ActiveRecord::Base.establish_connection if defined?(ActiveRecord::Base)
  Thread.new { EM.run }
end