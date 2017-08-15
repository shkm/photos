class CreateAlbums < ActiveRecord::Migration
  def self.up
    create_table :albums do |t|
      t.column :name, :string, null: :false
      t.column :body, :text
    end
  end
end
