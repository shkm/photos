require 'dotenv/load'
require 'require_all'
require 'active_record'

load_all 'config/*.rb'

require_all 'lib'
require_all 'models'

# External pipelines
webpack_command = if build?
                    'BUILD_PRODUCTION=1 ./node_modules/webpack/bin/webpack.js --bail'
                  else
                    'BUILD_DEVELOPMENT=1 ./node_modules/webpack/bin/webpack.js --watch -d --progress --color'
                  end

activate :external_pipeline,
  name: :webpack,
  command: webpack_command,
  source: ".tmp/dist",
  latency: 1

set :css_dir, 'assets/stylesheets'
set :js_dir, 'assets/javascripts'
set :images_dir, 'images'

# Layouts
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false
# page '/albums/*.html', layout: 'album'

# Proxies
Album.find_each do |album|
  proxy "/albums/#{album.id}.html",
    "/albums/template.html",
    locals: { album: album,
              title: album.name,
              subtitle: album.human_date },
    ignore: true
end

# Helpers
require_all 'helpers'
helpers AlbumHelpers

# Build

set :build_dir, 'docs'
after_build do |builder|
  File.open("#{Dir.pwd}/#{config.build_dir}/CNAME", 'w') { |f| f.write 'photos.schembri.me' }
end
# configure :build do
#   activate :minify_css
#   activate :minify_javascript
# end
