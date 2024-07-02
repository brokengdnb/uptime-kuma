module.exports = {
    devServer: {
        port: 3454,
        sockPath: "sockjs-node",
    },
    publicPath: process.env.NODE_ENV === 'production'
      ? '/'
      : '/'
  }
