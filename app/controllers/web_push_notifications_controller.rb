class WebPushNotificationsController < ApplicationController
  before_action :set_web_push_notification, only: [:show, :update, :destroy]

  # GET /web_push_notifications
  def index
    @web_push_notifications = WebPushNotification.all

    render json: @web_push_notifications
  end

  # GET /web_push_notifications/1
  def show
    render json: @web_push_notification
  end

  # POST /web_push_notifications
  def create
    @web_push_notification = WebPushNotification.new(web_push_notification_params)

    if @web_push_notification.save
      render json: @web_push_notification, status: :created, location: @web_push_notification
    else
      render json: @web_push_notification.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web_push_notifications/1
  def update
    if @web_push_notification.update(web_push_notification_params)
      render json: @web_push_notification
    else
      render json: @web_push_notification.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web_push_notifications/1
  def destroy
    @web_push_notification.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_web_push_notification
      @web_push_notification = WebPushNotification.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def web_push_notification_params
      params.require(:web_push_notification).permit(:title, :body)
    end
end
