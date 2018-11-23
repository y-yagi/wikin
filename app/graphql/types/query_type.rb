module Types
  class QueryType < Types::BaseObject
    field :page, Types::PageType, null: true do
      argument :id, ID, required: true
      description "Find a Page by ID"
    end

    field :pages, [Types::PageType], null: true do
      description "Get Pages"
    end

    field :search, [Types::PageType], null: true do
      argument :query, String, required: true
      description "Search Pages"
    end

    def page(id:)
      Page.find(id)
    end

    def pages
      Page.order('updated_at DESC').limit(Page::RECENT_PAGE_COUNT_SMT)
    end

    def search(query:)
      Page::Search.new(query).matches
    end
  end
end
