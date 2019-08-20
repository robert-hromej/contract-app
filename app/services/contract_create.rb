class ContractCreate < BaseService
  attr_reader :form

  def initialize(form:)
    @form = form
  end

  def call
    return Error.new('form is nil') if form.nil?
    return Error.new(form.errors) unless form.valid?

    Success.new(Contract.create(form.to_params))
  end
end
