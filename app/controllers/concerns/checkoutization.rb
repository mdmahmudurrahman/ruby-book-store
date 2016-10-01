# frozen_string_literal: true
module Checkoutization
  extend ActiveSupport::Concern

  included do
    private

    def address_form_params
      address_parameters = %i(id firstname lastname city
                              street country zipcode phone)

      if params.dig :'as-billing-address'
        billing = :billing_address_attributes
        shipping = :shipping_address_attributes
        params[shipping] = params[billing].merge id: params[shipping][:id]
      end

      params.permit billing_address_attributes: address_parameters,
                    shipping_address_attributes: address_parameters
    end

    def delivery_form_params
      params[:order_detail].permit :delivery_method_id
    end

    def payment_form_params
      credit_card_params = %i(id firstname lastname
                              number month year code)

      params.permit credit_card_attributes: credit_card_params
    end

    def confirm_form_params
      { step: step }
    end
  end
end
