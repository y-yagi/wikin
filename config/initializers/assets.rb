Rails.application.config.assets.precompile += %w(
  bootstrap-theme-white-plum/dist/fonts/glyphicons-halflings-regular.woff
  bootstrap-theme-white-plum/dist/fonts/glyphicons-halflings-regular.eot
  bootstrap-theme-white-plum/dist/fonts/glyphicons-halflings-regular.ttf
)
Rails.application.config.assets.version = '1.0'

Rails.application.config.assets.paths << Rails.root.join('node_modules')
