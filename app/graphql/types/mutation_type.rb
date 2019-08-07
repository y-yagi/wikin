# typed: strict
module Types
  class MutationType < Types::BaseObject
    field :updatePage, mutation: Mutations::UpdatePage
  end
end
