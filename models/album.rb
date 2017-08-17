class Album < ApplicationRecord
  has_many :photos
  belongs_to :cover_photo, class_name: 'Photo'

  validates :name, :cover_photo, presence: true
end
