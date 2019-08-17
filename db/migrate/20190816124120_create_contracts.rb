class CreateContracts < ActiveRecord::Migration[5.2]
  def change
    execute <<-SQL
      CREATE TYPE contract_status AS ENUM ('draft', 'signed');
    SQL

    create_table :contracts do |t|
      t.column :status, :contract_status, null: false
      t.string :name, null: false, limit: 255
      t.column :start_date, :date, null: false
      t.decimal :avg_monthly_price, precision: 8, scale: 2

      t.timestamps
    end
  end
end
