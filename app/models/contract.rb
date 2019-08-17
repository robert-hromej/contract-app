class NotInPastValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value.blank?
      record.errors.add attribute, (options[:message] || "can't be blank")
    elsif value < Date.today
      record.errors.add attribute, (options[:message] || "can't be in the past")
    end
  end
end

class Contract < ApplicationRecord
  validates :name, presence: true, length: { minimum: 1, maximum: 255 }
  validates :status, presence: true, inclusion: { in: %w(signed draft) }
  validates :start_date, presence: true, not_in_past: true
end
