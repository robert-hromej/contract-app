module Mutations
  class DestroyContract < BaseMutation
    description 'Mutations(endpoint) for destroying the Contract'

    null false

    argument :id, ID, required: true

    field :contract, Types::ContractType, null: true
    field :errors, [String], null: false

    def resolve(id:)
      contract = Contract.find(id)
      contract.destroy
      { contract: contract, errors: [] }
    end
  end
end
