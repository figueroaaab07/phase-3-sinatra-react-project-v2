class CreateUserApods < ActiveRecord::Migration[6.1]
  def change
    create_table :user_apods do |t|
      t.bigint :rating
      t.bigint :user_id
      t.bigint :apod_id
    end
  end
end
