module Mutations
  class CreateContract < BaseMutation
    description 'Mutations(endpoint) for creating new Contract'

    null false

    argument :input, Types::ContractAttributes, required: true

    field :contract, Types::ContractType, null: true
    field :errors, [String], null: false

    def resolve(input:)
      form = ContractForm.new(input.to_h)
      result = ContractCreate.new(form: form).call
      response(result: result)
    end
  end
end
