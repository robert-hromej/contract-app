require 'rails_helper'

describe ContractCreate, type: :service do
  let(:form) do
    ContractForm.new(
      name: 'first contract',
      status: 'draft',
      start_date: Date.today.iso8601,
      avg_monthly_price: 123.4
    )
  end

  subject { ContractCreate.new(form: form) }

  it 'is successful' do
    expect(subject.call).to be_success
  end

  it 'creates contract' do
    contract = subject.call.data

    expect(contract).to be_persisted
    expect(contract.name).to eq('first contract')
    expect(contract.status).to eq('draft')
    expect(contract.start_date).to eq(Date.today.iso8601)
    expect(contract.avg_monthly_price).to eq(123.4)

    expect(Contract.count).to eq(1)
  end

  it 'not creates contract' do
    service = ContractCreate.new(form: nil)
    result = service.call
    expect(result).to_not be_success
    expect(result.error).to eq('form is nil')

    service = ContractCreate.new(form: ContractForm.new(name: 'abc'))
    result = service.call
    expect(result).to_not be_success

    expect(result.error.messages).to include(
      status: ["can't be blank", 'is not included in the list'],
      start_date: ["can't be blank"]
    )
  end
end
