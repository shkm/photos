class Photo < ApplicationRecord
  LINK_SUFFIXES = {
    small_square: 's',
    big_square: 'b',
    small_thumbnail: 't',
    medium_thumbnail: 'm',
    large_thumbnail: 'l',
    huge_thumbnail: 'h'
  }.freeze

  belongs_to :album
  has_one :covered_album, class_name: 'Album', foreign_key: :cover_photo_id

  validates :external_id, presence: true

  after_commit :remote_delete, on: :destroy

  def self.create_with_upload(file, attributes = {})
    new(attributes).tap do |photo|
      uploaded = photo.upload(file)

      photo.save! if photo.uploaded?
    end
  end

  def link(format = :original)
    return super() if !format || (format == :original)

    super().split('.').tap do |splitted|
      splitted[-2] += LINK_SUFFIXES[format]
    end.join('.')
  end

  def uploaded?
    external_id.present?
  end

  def image
    @image ||= Imgur.image(external_id)
  end
  def upload(file)
    @image = Imgur.upload(file)

    return unless @image && @image.id.present?

    assign_attributes(
      external_id: image.id,
      name: image.name.presence,
      filename: File.basename(file.try(:path) || file),
      link: image.link,
      title: image.title,
      description: image.description,
      datetime: image.datetime,
      width: image.width,
      height: image.height,
      size: image.size
    )
  end

  private

  def remote_delete
    Imgur.delete(external_id)
  end
end
