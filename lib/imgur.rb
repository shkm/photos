module Imgur
  def self.session
    Imgurapi::Session.instance(
      client_id: ENV['IMGUR_CLIENT_ID'],
      client_secret: ENV['IMGUR_CLIENT_SECRET'],
      access_token: ENV['IMGUR_ACCESS_TOKEN'],
      refresh_token: ENV['IMGUR_REFRESH_TOKEN']
    )
  end

  def self.image(id)
    session.image.image(id)
  end
  
  def self.upload(file)
    session.image.image_upload(file)
  rescue
    Middleman::Logger.singleton.error("Failed to upload #{file}")

    return
  end

  def self.delete(id)
    session.image.image_delete(id)
  end
end
