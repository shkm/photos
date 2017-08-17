class RemoveBodyFromAlbums < ActiveRecord::Migration
  def self.up
    remove_column :albums, :body
  end
end
