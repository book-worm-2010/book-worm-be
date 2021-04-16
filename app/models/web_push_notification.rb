class WebPushNotification < ApplicationRecord
  with_options presence: true, length: { maximum: 100 } do 
    validates :title
    validates :body
  end

  after_create :publish

  def message
    { title: title , body: body }.to_json
  end

  protected

  def publish
    Subscription.all.each do |subscription|
      begin
        Webpush.payload.send(
          message: message, 
          ednpoint: subscription.endpoint,
          p256dh: subscription.p256dh,
          auth: subscription.auth,
          vapid: {
            subject: "mailto:sender@example.com",
            public_key: ENV['VAPID_PUBLIC_KEY'],
            private_key: ENV['VAPID_PRIVATE_KEY']
          }
        )
      rescue => exception
        logger.info.exception.mesage
      end
    end
  end
end
