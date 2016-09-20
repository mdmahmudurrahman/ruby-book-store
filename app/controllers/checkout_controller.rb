# frozen_string_literal: true
class CheckoutController < ApplicationController
  include Wicked::Wizard
  include Orderization
  include Checkoutization

  decorates_assigned :order, :details

  before_action :authenticate_user!,
                :initialize_entities

  before_action :check_step_permissions
  before_action :initialize_params, only: :update

  %i(address delivery payment).each do |step|
    before_action :"initialize_#{step}", only: :show, if: "step == :#{step}"
  end

  helper_method :steps, :current_step?

  steps :address, :delivery, :payment, :confirm

  def index
    redirect_to wizard_path @details.step
  end

  def show
    render_wizard
  end

  def update
    @details.assign_attributes @params
    render_wizard @details
  end

  private

  def initialize_entities
    @order = current_order
    @details = @order.details
  end

  def initialize_address
    %i(billing_address shipping_address).each do |field|
      address_missing = @details.send(field).nil?
      address = current_user.send(field).dup || Address.new
      @details.send "#{field}=", address if address_missing
    end
  end

  def initialize_delivery
    @details.set_delivery_method
  end

  def initialize_payment
    @details.build_credit_card
  end

  def initialize_params
    params = send("#{@step}_form_params").to_h
    @params = { step: next_step }.merge params
  end

  def finish_wizard_path
    @order.checkout
    @order.save

    order_path @order
  end

  def past_step?(step)
    super(step.to_sym)
  end

  def jump_to(step)
    super(step.to_sym)
  end

  def check_step_permissions
    jump_to @details.step if past_step? @details.step
  end
end
