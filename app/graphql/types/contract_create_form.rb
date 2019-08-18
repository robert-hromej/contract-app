class Types::ContractCreateForm < Types::BaseInputObject
  description 'Attributes for creating a contract'

  argument :status, String, 'status of contract(draft & signed)', required: true # Todo custom Enum type ?
  argument :name, String, 'name of contract', required: true
  argument :start_date, String, 'start date of contract', required: true # Todo custom Date type ?
  argument :avg_monthly_price, String, 'average monthly price of contract', required: false # Todo custom Float type ?
end
