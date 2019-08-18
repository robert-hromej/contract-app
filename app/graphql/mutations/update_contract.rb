class Mutations::UpdateContract < Mutations::CreateContract
  description 'Mutations(endpoint) for updating the Contract attributes'

  argument :input, Types::ContractUpdateForm, required: true

  def resolve(input:)
    contract = Contract.find(input.id)

    if contract.update(input.to_hash)
      { contract: contract, errors: [] }
    else
      { contract: nil, errors: contract.errors.full_messages }
    end
  end
end
