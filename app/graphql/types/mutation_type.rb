class Types::MutationType < Types::BaseObject
  description 'Mutations for Updating Contracts'

  field :create_contract, mutation: Mutations::CreateContract
  field :destroy_contract, mutation: Mutations::DestroyContract
  field :update_contract, mutation: Mutations::UpdateContract
end
