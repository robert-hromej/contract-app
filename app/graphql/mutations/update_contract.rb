class Mutations::UpdateContract < Mutations::CreateContract
  description 'endpoint for updating the Contract attributes'

  argument :id, ID, required: true

  def resolve(id:,
              status:,
              name:,
              start_date:,
              avg_monthly_price:)

    contract = Contract.find(id)

    params = { status: status,
               name: name,
               start_date: start_date,
               avg_monthly_price: avg_monthly_price }

    if contract.update(params)
      { contract: contract, errors: [] }
    else
      { contract: nil, errors: contract.errors.full_messages }
    end
  end
end
