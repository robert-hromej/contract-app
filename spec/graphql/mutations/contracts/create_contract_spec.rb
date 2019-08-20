require 'rails_helper'

RSpec.describe 'Mutations::CreateContract', type: :request do
  describe '.resolve' do
    it 'creates a contract' do
      contract = create(:contract, name: 'first contract')

      input = {
        status: contract.status,
        name: 'second contract',
        startDate: contract.start_date.to_datetime.iso8601,
        avgMonthlyPrice: contract.avg_monthly_price.to_f
      }

      json = {}
      errors = []

      expect do
        post '/graphql', params: { query: query, variables: { input: input } }, as: :json
        json = JSON.parse(response.body)
        errors = json['data']['createContract']['errors']
        puts errors unless errors.blank?
      end.to change { Contract.count }.by(1)

      expect(errors).to be_empty

      data = json['data']['createContract']['contract']

      expect(data).to include(
        'id' => be_present,
        'status' => contract.status,
        'name' => 'second contract',
        'startDate' => contract.start_date.iso8601,
        'avgMonthlyPrice' => contract.avg_monthly_price
      )
    end
  end

  def query
    <<~GQL
      mutation createContract($input: ContractAttributes!) {
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
