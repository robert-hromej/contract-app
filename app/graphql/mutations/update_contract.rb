module Mutations
  class UpdateContract < Mutations::CreateContract
    description 'Mutations(endpoint) for updating the Contract attributes'

    argument :id, ID, required: true

    def resolve(id:, input:)
      form = ContractForm.new(input.to_h)
      result = ContractUpdate.new(id: id, form: form).call
      response(result: result)
    end
  end
end
