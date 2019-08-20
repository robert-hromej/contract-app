# TODO: remove
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
  enum status: { signed: 'signed', draft: 'draft' }

  # TODO: remove
  validates :name, presence: true, uniqueness: true, length: { minimum: 1, maximum: 255 }
  validates :status, presence: true, inclusion: { in: %w[signed draft] }
  validates :start_date, presence: true, not_in_past: true

  def start_date
    self[:start_date].to_datetime
  end
end
