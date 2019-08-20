class ContractForm
  include ActiveModel::AttributeAssignment
  include ActiveModel::Validations

  attr_writer :start_date, :avg_monthly_price
  attr_accessor :name, :status

  validates :name, presence: true, length: { minimum: 1, maximum: 255 }
  validates :status, presence: true, inclusion: { in: %w[signed draft] }
  validates :start_date, presence: true

  validate :name_uniqueness
  validate :start_date_validation

  def initialize(attributes = {})
    assign_attributes(attributes) if attributes
    super()
  end

  def name_uniqueness
    errors.add(:name, ' is already taken!') if Contract.find_by(name: name)
  end

  def start_date_validation
    errors.add(:start_date, ' only today or future dates are allowed') if start_date && (start_date < Date.today)
  end

  def start_date
    return nil if @start_date.nil?

    return Date.parse(@start_date) if @start_date.is_a? String
    return @start_date if @start_date.is_a? DateTime

    nil
  rescue ArgumentError
    nil
  end

  def avg_monthly_price
    Float(@avg_monthly_price) if @avg_monthly_price
  rescue StandardError
    nil
  end

  def to_params
    {
      name: name,
      status: status,
      start_date: start_date.iso8601,
      avg_monthly_price: avg_monthly_price
    }
  end
end
