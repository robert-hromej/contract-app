require 'rails_helper'

RSpec.describe Types::QueryType, type: :request do
  it 'returns all items' do
    create(:contract,
           status: 'signed',
           name: 'my first contract',
           start_date: Date.today,
           avg_monthly_price: 123)

    create(:contract,
           status: 'draft',
           name: 'my second contract',
           start_date: Date.today + 1.days,
           avg_monthly_price: 321)

    post '/graphql', params: { query: query }
    json = JSON.parse(response.body)
    data_first = json['data']['contracts'][0]
    data_second = json['data']['contracts'][1]

    expect(data_first).to include('status' => 'signed',
                                  'name' => 'my first contract',
                                  'startDate' => Date.today.strftime('%F'),
                                  'avgMonthlyPrice' => 123)

    expect(data_second).to include('status' => 'draft',
                                   'name' => 'my second contract',
                                   'startDate' => (Date.today + 1.days).strftime('%F'),
                                   'avgMonthlyPrice' => 321)

    expect(Contract.count).to eq(2)
  end

  def query
    <<~GQL
      query {
        contracts {
            id
            status
            name
            startDate
            avgMonthlyPrice
        }
      }
    GQL
  end
end
