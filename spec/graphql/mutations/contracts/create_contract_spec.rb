require 'rails_helper'

RSpec.describe Mutations::CreateContract, type: :request do
  describe '.resolve' do
    it 'creates a contract' do
      contract = create(:contract)

      params = {
        status: contract.status,
        name: contract.name,
        start_date: contract.start_date,
        avg_monthly_price: contract.avg_monthly_price.to_s
      }

      expect do
        post '/graphql', params: { query: query(params) }
      end.to change { Contract.count }.by(1)
    end

    it 'returns a contact' do
      contract = create(:contract)

      params = {
        status: contract.status,
        name: contract.name,
        start_date: contract.start_date.strftime('%F'),
        avg_monthly_price: contract.avg_monthly_price.to_s
      }

      post '/graphql', params: { query: query(params) }
      json = JSON.parse(response.body)
      data = json['data']['createContract']['contract']
      errors = json['data']['createContract']['errors']

      expect(data).to include(
        'id' => be_present,
        'status' => contract.status,
        'name' => contract.name,
        'startDate' => contract.start_date.strftime('%F'),
        'avgMonthlyPrice' => contract.avg_monthly_price.to_f
      )
      expect(errors).to be_empty
    end
  end

  def query(status:, name:, start_date:, avg_monthly_price:)
    <<~GQL
      mutation {
        createContract(
          status: "#{status}"
          name: "#{name}"
          startDate: "#{start_date}"
          avgMonthlyPrice: #{avg_monthly_price}
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
