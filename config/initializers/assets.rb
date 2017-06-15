Rails.application.config.assets.precompile += %w(
  bootstrap-theme-white-plum/dist/fonts/glyphicons-halflings-regular.woff
  bootstrap-theme-white-plum/dist/fonts/glyphicons-halflings-regular.eot
  bootstrap-theme-white-plum/dist/fonts/glyphicons-halflings-regular.ttf
)

if Rails.env.development?
Rails.application.config.assets.precompile += %w(
  graphiql/rails/application.css
  graphiql/rails/application.js
)
end

Rails.application.config.assets.version = '1.0'

Rails.application.config.assets.paths << Rails.root.join('node_modules')
