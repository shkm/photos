require 'dotenv/load'
require 'imgurapi'
load 'imgurapi/tasks/tasks.rake'

require 'active_record'
require 'require_all'
require 'yaml'

namespace :albums do
  desc "Add photos to a new or existing album, and upload them."
  # If files already exist in the album, skip them.
  task :add_photos, [:name, :date, :photos_directory] do |_, args|
    # TODO: move these requires / loads somewhere else.
    # Perhaps just load middleman first.

    require 'require_all'
    require 'active_record'

    load_all 'config/*.rb'

    require_all 'lib'
    require_all 'models'

    require 'middleman'

    album = Album.find_or_create_by!(
      name: args[:name],
      date: args[:date]
    )

    logger = Middleman::Logger.singleton

    Dir["#{args[:photos_directory]}/*.jpg"].each do |path|
      if album.photos.exists?(filename: File.basename(path))
        logger.info "Skipping #{path}."
        next
      end

      photo = Photo.create_with_upload(path, album: album)

      # We'll already get a log message on failure.
      next unless photo.uploaded?

      logger.info "Uploaded #{path} to #{photo.link}."
    end
  end
end

namespace :db do
  db_config       = YAML::load(File.open('config/database.yml'))
  db_config_admin = db_config

  desc "Create the database"
  task :create do
    ActiveRecord::Base.establish_connection(db_config_admin)
    unless db_config_admin['adapter'] == 'sqlite3'
      ActiveRecord::Base.connection.create_database(db_config["database"])
    end
    puts "Database created."
  end

  desc "Seed the database"
  task :seed do
    ActiveRecord::Base.establish_connection(db_config_admin)
    require_all 'models/*.rb'
    require_relative 'db/seeds.rb'
  end

  desc "Migrate the database"
  task :migrate do
    ActiveRecord::Base.establish_connection(db_config)
    ActiveRecord::Migrator.migrate("db/migrate/")

    Rake::Task["db:schema"].invoke
    puts "Database migrated."
  end

  desc "Drop the database"
  task :drop do
    ActiveRecord::Base.establish_connection(db_config_admin)
    ActiveRecord::Base.connection.drop_database(db_config["database"])
    puts "Database deleted."
  end

  desc "Reset the database"
  task :reset => [:drop, :create, :migrate]

  desc 'Create a db/schema.rb file that is portable against any DB supported by AR'
  task :schema do
    ActiveRecord::Base.establish_connection(db_config)
    require 'active_record/schema_dumper'
    filename = "db/schema.rb"
    File.open(filename, "w:utf-8") do |file|
      ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, file)
    end
  end

end

namespace :g do
  desc "Generate migration"
  task :migration do
    name = ARGV[1] || raise("Specify name: rake g:migration your_migration")
    timestamp = Time.now.strftime("%Y%m%d%H%M%S")
    path = File.expand_path("../db/migrate/#{timestamp}_#{name}.rb", __FILE__)
    migration_class = name.split("_").map(&:capitalize).join

    File.open(path, 'w') do |file|
      file.write <<-EOF
class #{migration_class} < ActiveRecord::Migration
  def self.up
  end
  def self.down
  end
end
      EOF
    end

    puts "Migration #{path} created"
    abort # needed stop other tasks
  end
end
