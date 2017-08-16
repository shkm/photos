# Photos
[photos.schembri.me](photos.schembri.me)

This is a little site for sharing my photos. The focus was to build something simple, easy to maintain, and cost-free.

## Technology
- Middleman is used for the overall site
- Imgur is used for image hosting
- Bulma for style
- sqlite3 to store stuff locally (like photo links)

## Dependencies

* Ruby
* Bundler
* Yarn
* sqlite3

## Dev setup

```sh
bundle install
bundle exec rake db:create db:migrate
yarn install
```

[Auth with Imgur](https://github.com/dncrht/imgur#authorize-your-ruby-application), and copy details into `.env` in the following format:

```sh
IMGUR_CLIENT_ID=
IMGUR_CLIENT_SECRET=
IMGUR_ACCESS_TOKEN=
IMGUR_REFRESH_TOKEN=
```

## Uploading photos

This task may need to be run a few times before all photos complete upload.  Imgur's rate limits don't seem to be quite that set in stone.
```sh
rake albums:add_photos['album name','folder_path']
```

