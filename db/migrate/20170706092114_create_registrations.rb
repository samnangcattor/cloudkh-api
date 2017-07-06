class CreateRegistrations < ActiveRecord::Migration[5.0]
  def change
    create_table :registrations do |t|
      t.references :payment_plan, index: true
      t.string :full_name
      t.string :email
      t.string :telephone
      t.text :notification_params
      t.integer :status
      t.string :transaction_id
      t.datetime :purchased_at

      t.timestamps
    end
  end
end
