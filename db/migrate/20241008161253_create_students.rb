class CreateStudents < ActiveRecord::Migration[7.0]
  def change
    create_table :students do |t|
      t.string :name
      t.decimal :total_amount
      t.integer :number_of_installments

      t.timestamps
    end
  end
end
