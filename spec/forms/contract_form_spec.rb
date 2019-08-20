require 'rails_helper'

describe ContractForm, type: :form do
  subject do
    ContractForm.new(
      name: 'first contract',
      status: 'draft',
      start_date: Date.today.iso8601
    )
  end

  context '#validations' do
    it 'should have valid' do
      subject.should be_valid
    end

    {
      name: ['a', 'a' * 255],
      status: %w[signed draft],
      start_date: [Time.now, Time.now + 10.minutes].map(&:iso8601)
    }.each do |key, values|
      values.each do |value|
        it "should have valid with #{key} = '#{value.to_s[0..32]}'" do
          subject.assign_attributes(key => value)
          subject.should be_valid
        end
      end
    end

    {
      name: [nil, '', 'a' * 256],
      status: [nil, '', 'wrong'],
      start_date: [nil, 'wrong', 1.days.ago.iso8601]
    }.each do |key, values|
      values.each do |value|
        it "should require not valid #{key} = '#{value.to_s[0..32]}'" do
          subject.assign_attributes(key => value)
          subject.should_not be_valid
        end
      end
    end
  end
end
