module AlbumHelpers
  def album_link(album, text = album.name, &block)
    path = [:albums, album.id].join('/')

    return link_to(path, &block) if block_given?

    link_to text, path
  end
end
