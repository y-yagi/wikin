# typed: strict
class WikinSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)
end
