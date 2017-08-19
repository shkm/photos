class Album < ApplicationRecord
  has_many :photos
  belongs_to :cover_photo, class_name: 'Photo'

  validates :name, presence: true

  def human_date
    date&.strftime("%e %B ’%y")
  end
end
