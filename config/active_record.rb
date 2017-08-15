config = YAML::load(File.open('config/database.yml'))
ActiveRecord::Base.establish_connection(config)
