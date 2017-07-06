class Registration < ApplicationRecord
  belongs_to :payment_plan
  enum status: [:pending, :failed, :completed]

  validates :email, :full_name, :telephone, presence: true
  serialize :notification_params, Hash

  def paypal_url(return_path)
    values = {
      business: '<%= ENV["PAYPAL_MERCHANT_EMAIL"] %>',
      cmd: "_xclick",
      upload: 1,
      return: "#{ENV["APP_HOST"]}#{return_path}",
      invoice: id,
      amount: course.price,
      item_name: course.name,
      item_number: course.id,
      quantity: '1',
      notify_url: "#{ENV["APP_HOST"]}/hook"
    }
    "#{ENV["PAYPAL_HOST"]}/cgi-bin/webscr?" + values.to_query
  end
end
