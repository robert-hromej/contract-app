require 'rails_helper'

describe ContractUpdate, type: :service do
  let(:form) do
    ContractForm.new(
      name: 'changed contract name',
      status: 'draft',
      start_date: (Date.today + 1.days).iso8601,
      avg_monthly_price: 432.1
    )
  end

  it 'updates a contract' do
    contract = create(:contract,
                      status: 'signed',
                      name: 'my first contract',
                      start_date: Date.today,
                      avg_monthly_price: 123.4)

    service = ContractUpdate.new(id: contract.id, form: form)
    result = service.call
    expect(result).to be_success
    result_contract = result.data

    expect(result_contract).to have_attributes(
      'status' => 'draft',
      'name' => 'changed contract name',
      'start_date' => (Date.today + 1.days),
      'avg_monthly_price' => 432.1
    )

    expect(contract.reload).to have_attributes(
      'status' => 'draft',
      'name' => 'changed contract name',
      'start_date' => (Date.today + 1.days),
      'avg_monthly_price' => 432.1
    )
  end
end
