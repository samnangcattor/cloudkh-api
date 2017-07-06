class RegistrationsController < ApplicationController
  before_action :set_registration, only: [:show, :edit, :update, :destroy]

  def index
    @registrations = Registration.all
  end

  def show
  end

  def new
    @registration = Registration.new
    @course = PaymentPlan.find_by id: params["payment_plan_id"]
  end

  def create
    @registration = Registration.new registration_params
    if @registration.save
      redirect_to @registration.paypal_url(registration_path(@registration))
    else
      render :new
    end
  end

  protect_from_forgery except: [:hook]
  def hook
    params.permit! # Permit all Paypal input params
    status = params[:payment_status]
    if params[:payment_status] == Registration.statuses.completed
      @registration = Registration.find params[:invoice]
      # @registration.update_attributes notification_params: params, status: status, transaction_id: params[:txn_id], purchased_at: Time.zone.now
      @registration.update_attributes build_registration_params(params)
    end
    render nothing: true
  end

  private
  def set_registration
    @registration = Registration.find(params[:id])
  end

  def registration_params
    params.require(:registration).permit(:payment_plan_id, :email, :full_name, :telephone)
  end

  def build_registration_params params
    {
      notification_params: params,
      status: params[:payment_status],
      transaction_id: params[:txn_id]
      purchased_at: Time.zone.now
    }
  end
end
