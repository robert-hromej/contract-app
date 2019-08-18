class UniqueIndexForContracts < ActiveRecord::Migration[5.2]
  def change
    Contract.delete_all
    add_index :contracts, :name, unique: true
  end
end
