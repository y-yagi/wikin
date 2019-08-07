# typed: true
module Mutations
  class UpdatePage < GraphQL::Schema::RelayClassicMutation
    field :id, ID, null: false

    argument :id, ID, required: true
    argument :title, String, required: false
    argument :body, String, required: false


    def resolve(id:, title:, body:)
      page = Page.find(id)
      page.title = title if title
      page.body = body if body
      page.save!

      { id: page.id }
    end
  end
end
