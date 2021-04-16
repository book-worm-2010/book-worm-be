class CreateWebPushNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :web_push_notifications do |t|
      t.string :title
      t.string :body

      t.timestamps
    end
  end
end
