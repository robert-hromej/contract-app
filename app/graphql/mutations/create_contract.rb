class Mutations::CreateContract < Mutations::BaseMutation
  description 'endpoint for creating new Contract'

  null true

  argument :status, String, required: true
  argument :name, String, required: true
  argument :start_date, String, required: true
  argument :avg_monthly_price, Float, required: false

  field :contract, Types::ContractType, null: true
  field :errors, [String], null: false

  def resolve(
    status:,
    name:,
    start_date:,
    avg_monthly_price:
  )

    params = { status: status,
               name: name,
               start_date: start_date,
               avg_monthly_price: avg_monthly_price }

    contract = Contract.new(params)

    if contract.save
      { contract: contract, errors: [] }
    else
      { contract: nil, errors: contract.errors.full_messages }
    end
  end
end
