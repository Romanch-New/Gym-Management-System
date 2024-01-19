# frozen_string_literal: true

class BusinessesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin, only: %i[show create edit update destroy]

  def index
    @businesses = current_user.businesses
  end

  def show
    @business = Business.find(params[:id])
    @users = @business.users
    # @invitations = @business.invitations
  end

  def new
    @business = Business.new
  end

  def create
    @business = Business.new(business_params)
    @business.user_id = current_user.id
    if @business.save
      redirect_to @business, notice: 'Business created successfully.'
    else
      render :new
    end
  end

  def edit
    @business = Business.find(params[:id])
  end

  def update
    @business = Business.find(params[:id])
    if @business.update(business_params)
      redirect_to @business, notice: 'Business updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @business = Business.find(params[:id])
    @business.destroy
    redirect_to root_path, notice: 'Business deleted successfully.'
  end

  private

  def business_params
    params.require(:business).permit(:name, :business_type)
  end

  def ensure_admin
    return if current_user.admin?

    redirect_to root_path, alert: 'You are not authorized to access this page.'
  end
end
