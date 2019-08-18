class Types::ContractUpdateForm < Types::ContractCreateForm
  description 'Attributes for updating a contract'

  argument :id, ID, 'ID of contract', required: true
end
