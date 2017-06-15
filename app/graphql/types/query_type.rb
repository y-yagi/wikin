Types::QueryType = GraphQL::ObjectType.define do
  name "Query"
  # Add root-level fields here.
  # They will be entry points for queries on your schema.

  field :page do
    type Types::PageType
    argument :id, !types.ID
    description "Find a Page by ID"
    resolve ->(obj, args, ctx) do
      Page.find(args["id"])
    end
  end

  field :pages, types[Types::PageType] do
    description "get Pages"
    resolve ->(obj, args, ctx) do
      Page.order('updated_at DESC').limit(Page::RECENT_PAGE_COUNT_SMT)
    end
  end
end
