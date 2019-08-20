require_relative '../enums/contract_status_enum'

module Types
  class ContractType < Types::BaseObject
    field :id, ID, null: false
    field :status, ContractStatusEnum, null: false
    field :name, String, null: false
    field :start_date, GraphQL::Types::ISO8601DateTime, null: false
    field :avg_monthly_price, Float, null: true
  end
end
