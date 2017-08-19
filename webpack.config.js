const webpack = require("webpack")
const CopyWebpackPlugin = require('copy-webpack-plugin');
const ExtractTextPlugin = require("extract-text-webpack-plugin")
const definePlugin = new webpack.DefinePlugin({
  __DEVELOPMENT__: JSON.stringify(JSON.parse(process.env.BUILD_DEVELOPMENT || false)),
  __PRODUCTION__: JSON.stringify(JSON.parse(process.env.BUILD_PRODUCTION || false))
})

const extractSass = new ExtractTextPlugin(
  "assets/stylesheets/[name].bundle.css"
)

module.exports = {
  /// https://github.com/webpack-contrib/css-loader/issues/447
  node: {
    fs: "empty"
  },
  entry: [
    __dirname + "/assets/javascripts/main.js",
    __dirname + "/assets/stylesheets/main.sass"
  ],
         
  output: {
    publicPath: "//photos.schembri.me/",
    path: __dirname + "/.tmp/dist",
    filename: "assets/javascripts/[name].bundle.js"
  },

  module: {
    rules: [{
      test: /\.(sass|scss)$/,
      use: extractSass.extract({
        use: [{
          loader: "css-loader"
        }, {
          loader: "sass-loader"
        }],
        // use style-loader in development
        fallback: "style-loader"
      })
    }, {
      test: /\.js$/,
      exclude: /(node_modules|bower_components)/,
      use: {
        loader: "babel-loader",
        options: {
          "presets": [
            ["env", {
              "targets": {
                "browsers": ["> 5%"]
              }
            }]
          ]
        }
      }
    }, {
      test: /\.(png|jpg|gif|eof|woff)$/,
      use: [
        {
          loader: 'file-loader',
          options: {}  
        }
      ]
    }]
  },

  plugins: [
    definePlugin,
    extractSass,
    new CopyWebpackPlugin([
      { from: 'node_modules/lightgallery.js/dist', to: 'lightgallery' },
    ])
  ]
}
