class ContractDestroy < BaseService
  attr_reader :id

  def initialize(id:)
    @id = id
  end

  def call
    return Error.new('id is nil') if id.nil?

    contract = Contract.destroy(id)

    if contract
      Success.new(contract)
    else
      Error.new("can not find Contract with id '#{id}'")
    end
  end
end
