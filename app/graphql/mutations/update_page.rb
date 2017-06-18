Mutations::UpdatePage = GraphQL::Relay::Mutation.define do
  name "UpdatePage"

  input_field :id, !types.ID
  input_field :title, types.String
  input_field :body, types.String

  return_field :id, !types.ID

  # The resolve proc is where you alter the system state.
  resolve ->(object, inputs, ctx) {
    page = Page.find(inputs[:id])
    page.title = inputs[:title] if inputs[:title]
    page.body = inputs[:body] if inputs[:body]
    page.save!

    response = {
      id: page.id
    }
  }
end
