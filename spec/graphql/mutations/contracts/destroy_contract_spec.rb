require 'rails_helper'

RSpec.describe Mutations::DestroyContract, type: :request do
  describe 'resolve' do
    it 'removes a contract' do
      contract = create(:contract)

      expect do
        post '/graphql', params: { query: query(id: contract.id) }
      end.to change { Contract.count }.by(-1)
    end

    it 'returns a contract' do
      contract = create(:contract, name: 'test contract name')

      post '/graphql', params: { query: query(id: contract.id) }
      json = JSON.parse(response.body)
      data = json['data']['destroyContract']['contract']
      errors = json['data']['destroyContract']['errors']

      expect(data).to include(
        'id' => be_present,
        'status' => contract.status,
        'name' => 'test contract name',
        'startDate' => contract.start_date.strftime('%F'),
        'avgMonthlyPrice' => contract.avg_monthly_price.to_f
      )
      expect(errors).to be_empty
    end
  end

  def query(id:)
    <<~GQL
      mutation {
        destroyContract(
          id: #{id}
        ) {
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
