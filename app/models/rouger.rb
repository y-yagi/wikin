require 'rouge/plugins/redcarpet'

class Rouger < Redcarpet::Render::HTML
  include Rouge::Plugins::Redcarpet
end
