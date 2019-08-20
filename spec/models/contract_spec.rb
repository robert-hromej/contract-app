require 'rails_helper'

RSpec.describe Contract, type: :model do
  subject(:new_contract_params) { { status: 'draft', name: 'Contract#1', start_date: Time.now + 1.minutes } }

  context '#validations' do
    it 'should have valid' do
      build(:contract).should be_valid
    end

    {
      name: ['a', 'a' * 255],
      status: %w[signed draft],
      start_date: [Time.now, Time.now + 10.minutes]
    }.each do |key, values|
      values.each do |value|
        it "should have valid with #{key} = '#{value.to_s[0..32]}'" do
          build(:contract, key => value).should be_valid
        end
      end
    end

    {
      name: [nil, '', 'a' * 256],
      status: [nil, ''], # TODO: 'failed'
      start_date: [1.days.ago]
    }.each do |key, values|
      values.each do |value|
        it "should require not valid #{key} = '#{value.to_s[0..32]}'" do
          build(:contract, key => value).should_not be_valid
        end
      end
    end
  end
end
