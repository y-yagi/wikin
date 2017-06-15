Types::PageType = GraphQL::ObjectType.define do
  name "Page"
  field :id, !types.ID
  field :title, !types.String
  field :body, !types.String
  field :url, !types.String do
    resolve ->(object, args, ctx) do
      object.to_path
    end
  end
  field :extracted_body, !types.String do
    resolve ->(object, args, ctx) do
      renderer = Rouger.new(hard_wrap: true)
      markdown = Redcarpet::Markdown.new(renderer, autolink: true, tables: true, fenced_code_blocks: true)
      markdown.render(object.body)
    end
  end
end
