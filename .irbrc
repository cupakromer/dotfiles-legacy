if ENV["RAILS_ENV"] == 'development' && defined?(ActiveRecord::Base)
  ActiveRecord::Base.logger = Logger.new STDOUT
  ActiveRecord::Base.connection_pool.clear_reloadable_connections!
end
