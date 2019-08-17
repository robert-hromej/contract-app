class Types::ContractType < Types::BaseObject
  field :id, ID, null: true
  field :status, Types::ContractStatusEnum, null: true
  field :name, String, null: true
  field :start_date, Types::DateType, null: true
  field :avg_monthly_price, Float, null: true
end
