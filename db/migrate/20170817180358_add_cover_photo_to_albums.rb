class AddCoverPhotoToAlbums < ActiveRecord::Migration
  def self.up
    add_reference :albums, :cover_photo, index: true
  end
end
