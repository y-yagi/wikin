Rails.application.configure do
  config.serviceworker.routes.draw do
    match "/serviceworker.js", pack: true
    match "/manifest.json", pack: true
  end
end
