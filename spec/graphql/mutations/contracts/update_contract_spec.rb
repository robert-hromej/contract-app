require 'rails_helper'

RSpec.describe 'Mutations::UpdateContract', type: :request do
  describe 'resolve' do
    it 'updates a contract' do
      contract = create(:contract,
                        status: 'signed',
                        name: 'my first contract',
                        start_date: Date.today,
                        avg_monthly_price: 123)

      input = {
        status: 'draft',
        name: 'my changed contract',
        startDate: (Date.today + 1.days).to_datetime.iso8601,
        avgMonthlyPrice: 321
      }

      post '/graphql', params: { query: query, variables: { id: contract.id, input: input } }, as: :json

      json = JSON.parse(response.body)
      errors = json['data']['updateContract']['errors']
      puts errors unless errors.blank?
      data = json['data']['updateContract']['contract']

      expect(data).to include(
        'status' => 'draft',
        'name' => 'my changed contract',
        'startDate' => (Date.today + 1.days).to_datetime.iso8601,
        'avgMonthlyPrice' => 321
      )
      expect(errors).to be_empty

      expect(contract.reload).to have_attributes(
        'status' => 'draft',
        'name' => 'my changed contract',
        'start_date' => (Date.today + 1.days),
        'avg_monthly_price' => 321
      )
    end
  end

  def query
    <<~GQL
      mutation updateContract($id: ID!, $input: ContractAttributes!) {
        updateContract(id: $id, input: $input) {
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
