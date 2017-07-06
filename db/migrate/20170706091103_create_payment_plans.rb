class CreatePaymentPlans < ActiveRecord::Migration[5.0]
  def change
    create_table :payment_plans do |t|
      t.string :name
      t.integer :price

      t.timestamps
    end
  end
end
