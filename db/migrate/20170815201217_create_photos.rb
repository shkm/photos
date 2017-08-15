class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      t.column :external_id, :string, null: false
      t.column :link, :string

      t.column :filename, :string
      t.column :name, :string
      t.column :title, :string
      t.column :description, :string
      t.column :datetime, :datetime
      t.column :width, :int
      t.column :height, :int
      t.column :size, :int

      t.references :album, index: true
    end
  end
end
