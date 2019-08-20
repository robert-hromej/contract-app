require_relative '../input_objects/contract_attributes.rb'

module Mutations
  class BaseMutation < GraphQL::Schema::Mutation
    def response(result:)
      if result.success?
        { contract: result.data, errors: [] }
      else
        { contract: nil, errors: result.errors.full_messages }
      end
    end
  end
end
