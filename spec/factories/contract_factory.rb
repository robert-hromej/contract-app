FactoryBot.define do
  factory :contract do
    status { %w[signed draft].sample }
    name { "name##{rand(1000)}" }
    start_date { Date.today.to_datetime.iso8601 }
    avg_monthly_price { (10 * rand).round(2) }
  end
end
