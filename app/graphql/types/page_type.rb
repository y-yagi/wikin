module Types
  class PageType < Types::BaseObject
    field :id, ID, null: false
    field :title,String, null: true
    field :body, String, null: true
    field :url, String, null: true
    field :extracted_body, String, null: true

    def url
      object.to_path
    end

    def extracted_body
      renderer = Rouger.new(hard_wrap: true)
      markdown = Redcarpet::Markdown.new(renderer, autolink: true, tables: true, fenced_code_blocks: true)
      markdown.render(object.body)
    end
  end
end
