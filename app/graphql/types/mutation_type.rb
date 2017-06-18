Types::MutationType = GraphQL::ObjectType.define do
  name "Mutation"

  field :updatePage, field: Mutations::UpdatePage.field
end
