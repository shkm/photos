module AlbumHelpers
  def album_link(album, text = album.name, &block)
    return link_to(album_path(album), &block) if block_given?

    link_to text, album_path(album)
  end

  def album_path(album)
    [:albums, album.id].join('/')
  end
end
