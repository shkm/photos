class AddDateToAlbums < ActiveRecord::Migration
  def self.up
    add_column :albums, :date, :date
  end
end
