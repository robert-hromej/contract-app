module Types
  class ContractAttributes < Types::BaseInputObject
    description 'Attributes of contract'

    argument :name, String, 'name of contract', required: true
    argument :status, Types::ContractStatusEnum, 'status of contract(draft & signed)', required: true
    argument :start_date, GraphQL::Types::ISO8601DateTime, 'start date of contract', required: true
    argument :avg_monthly_price, GraphQL::Types::Float, 'average monthly price of contract', required: false
  end
end
