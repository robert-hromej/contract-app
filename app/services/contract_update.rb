class ContractUpdate < BaseService
  attr_reader :id, :form

  def initialize(id:, form:)
    @id = id
    @form = form
  end

  def call
    return Error.new('id is nil') if id.nil?
    return Error.new('form is nil') if form.nil?
    return Error.new(form.errors) unless form.valid?

    contract = Contract.find(id)
    if contract.update(form.to_params)
      Success.new(contract)
    else
      Error.new(contract.errors)
    end
  end
end
