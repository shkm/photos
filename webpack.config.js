const webpack = require("webpack")
const ExtractTextPlugin = require("extract-text-webpack-plugin")

const definePlugin = new webpack.DefinePlugin({
  __DEVELOPMENT__: JSON.stringify(JSON.parse(process.env.BUILD_DEVELOPMENT || false)),
  __PRODUCTION__: JSON.stringify(JSON.parse(process.env.BUILD_PRODUCTION || false))
})

const extractSass = new ExtractTextPlugin(
  "assets/stylesheets/[name].bundle.css"
)

module.exports = {
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
    }]
  },

  plugins: [
    definePlugin,
    extractSass
  ]
}
