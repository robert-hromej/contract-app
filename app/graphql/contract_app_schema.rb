require 'queries/query_type'

class ContractAppSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)
end
