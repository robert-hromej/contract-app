module Mutations
  class DestroyContract < BaseMutation
    description 'Mutations(endpoint) for destroying the Contract'

    null false

    argument :id, ID, required: true

    field :contract, Types::ContractType, null: true
    field :errors, [String], null: false

    def resolve(id:)
      service = ContractDestroy.new(id: id)
      result = service.call
      response(result: result)
    end
  end
end
