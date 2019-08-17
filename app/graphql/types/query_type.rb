class Types::QueryType < Types::BaseObject
  description 'Query for Returning Contracts'

  field :contracts, [Types::ContractType], null: true, description: 'gets all contracts'

  def contracts
    Contract.all
  end
end
