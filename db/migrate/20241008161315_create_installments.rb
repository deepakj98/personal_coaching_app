class CreateInstallments < ActiveRecord::Migration[7.0]
  def change
    create_table :installments do |t|
      t.references :student, null: false, foreign_key: true
      t.decimal :amount
      t.boolean :paid
      t.datetime :payment_date

      t.timestamps
    end
  end
end
