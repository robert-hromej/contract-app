class Contract < ApplicationRecord
  enum status: { signed: 'signed', draft: 'draft' }

  def start_date
    self[:start_date].to_datetime
  end
end
