class Mutations::DestroyContract < Mutations::BaseMutation
  description 'endpoint for destroying the Contract'

  null true

  argument :id, ID, required: true

  field :contract, Types::ContractType, null: true
  field :errors, [String], null: false

  def resolve(id:)
    contract = Contract.find(id)
    contract.destroy
    { contract: contract, errors: [] }
  end
end
