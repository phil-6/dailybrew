# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[7.0]
  def change
    enable_extension 'pgcrypto'
    create_table :users, id: :uuid do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ''
      t.string :encrypted_password, null: false, default: ''

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      t.string   :unlock_token # Only if unlock strategy is :email or :both
      t.datetime :locked_at

      ## Additional Fields
      t.string    :first_name, null: false, default: ''
      t.string    :last_name, null: false, default: ''
      t.string    :username, default: ''
      t.boolean   :terms, default: false
      t.boolean   :subscription_interest, default: false

      t.boolean   :admin, default: false

      t.string    :address_ship_street
      t.string    :address_ship_area
      t.string    :address_ship_city
      t.string    :address_ship_county
      t.string    :address_ship_postcode
      t.string    :address_ship_phone
      t.string    :address_bill_street
      t.string    :address_bill_area
      t.string    :address_bill_city
      t.string    :address_bill_county
      t.string    :address_bill_postcode
      t.string    :address_bill_phone

      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :confirmation_token,   unique: true
    add_index :users, :unlock_token,         unique: true
  end
end
