require 'rails_helper'

RSpec.describe Mutations::UpdateContract, type: :request do
  describe 'resolve' do
    it 'updates a contract' do
      contract = create(:contract,
                        status: 'signed',
                        name: 'my first contract',
                        start_date: Date.today,
                        avg_monthly_price: 123)

      new_attributes = {
        id: contract.id,
        status: 'draft',
        name: 'my changed contract',
        start_date: Date.today + 1.days,
        avg_monthly_price: 321
      }

      post '/graphql', params: { query: query(new_attributes) }

      json = JSON.parse(response.body)
      data = json['data']['updateContract']['contract']
      errors = json['data']['updateContract']['errors']

      expect(data).to include(
        'status' => 'draft',
        'name' => 'my changed contract',
        'startDate' => (Date.today + 1.days).strftime('%F'),
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

  def query(id:, status:, name:, start_date:, avg_monthly_price:)
    <<~GQL
      mutation {
        updateContract(
          id: #{id}
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
