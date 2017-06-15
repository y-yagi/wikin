Types::PageType = GraphQL::ObjectType.define do
  name "Page"
  field :id, !types.ID
  field :title, !types.String
  field :body, !types.String
end
