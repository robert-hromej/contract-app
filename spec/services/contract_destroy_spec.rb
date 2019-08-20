require 'rails_helper'

describe ContractUpdate, type: :service do
  it 'removes a contract' do
    contract = create(:contract)

    service = ContractDestroy.new(id: contract.id)

    result = nil

    expect do
      result = service.call
    end.to change { Contract.count }.by(-1)

    result_contract = result.data

    expect(result_contract).to have_attributes(
      'name' => contract.name,
      'status' => contract.status,
      'start_date' => contract.start_date,
      'avg_monthly_price' => contract.avg_monthly_price
    )

    expect(Contract.find_by_id(contract)).to eq(nil)
  end
end
