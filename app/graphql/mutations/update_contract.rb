module Mutations
  class UpdateContract < Mutations::CreateContract
  description 'Mutations(endpoint) for updating the Contract attributes'

    argument :id, ID, required: true

    def resolve(id:, input:)
      contract = Contract.find(id)

      if contract.update(input.to_hash)
        { contract: contract, errors: [] }
      else
        { contract: nil, errors: contract.errors.full_messages }
      end
    end
  end
end
