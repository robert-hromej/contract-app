require 'rails_helper'

RSpec.describe Mutations::CreateContract, type: :request do
  describe '.resolve' do
    it 'creates a contract' do
      contract = create(:contract)

      input = {
          status: contract.status,
          name: contract.name,
          startDate: contract.start_date.strftime('%F'),
          avgMonthlyPrice: contract.avg_monthly_price.inspect
      }

      expect do
        post '/graphql', params: {query: query, variables: {input: input}}
      end.to change { Contract.count }.by(1)

      json = JSON.parse(response.body)
      errors = json['data']['createContract']['errors']
      expect(errors).to be_empty
      puts errors unless errors.blank?

      data = json['data']['createContract']['contract']

      expect(data).to include(
                          'id' => be_present,
                          'status' => contract.status,
                          'name' => contract.name,
                          'startDate' => contract.start_date.strftime('%F'),
                          'avgMonthlyPrice' => contract.avg_monthly_price.to_f
                      )
    end
  end

  def query
    <<~GQL
      mutation createContract($input: ContractCreateForm!) {
        createContract(input: $input) {
          contract {
            id
            status
            name
            startDate
            avgMonthlyPrice
          },
          errors
        }
      }
    GQL
  end
end
