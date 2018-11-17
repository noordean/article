class AddEmailAndSmsColumns < ActiveRecord::Migration[5.2]
  def change
    add_column :submissions, :email_sent, :string, default: "NO"
    add_column :submissions, :sms_sent, :string, default: "NO"
  end
end
