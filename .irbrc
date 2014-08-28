if ENV["RAILS_ENV"] == 'development'
  ActiveRecord::Base.logger = Logger.new STDOUT
  ActiveRecord::Base.connection_pool.clear_reloadable_connections!
end
