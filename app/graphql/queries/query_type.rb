module Types
  class QueryType < Types::BaseObject
    description 'Query for Returning Contracts'

    field :contract, ContractType, null: true, description: 'get contract by ID' do
      argument :id, ID, required: true
    end
    field :contracts, [ContractType], null: true, description: 'gets all contracts'

    def contract(id:)
      Contract.find(id)
    end

    def contracts
      Contract.all
    end
  end
end
