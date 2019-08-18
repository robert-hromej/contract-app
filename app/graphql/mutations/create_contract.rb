class Mutations::CreateContract < Mutations::BaseMutation
  description 'Mutations(endpoint) for creating new Contract'

  null true

  argument :input, Types::ContractCreateForm, required: true

  field :contract, Types::ContractType, null: true
  field :errors, [String], null: false

  def resolve(input:)
    contract = Contract.new(input.to_hash)

    if contract.save
      { contract: contract, errors: [] }
    else
      { contract: nil, errors: contract.errors.full_messages }
    end
  end
end
