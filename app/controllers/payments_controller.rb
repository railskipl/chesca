class PaymentsController < ApplicationController
  include ActiveMerchant::Billing

  def create
    unless current_cart.has_valid_delivery_option?
    @message = "please select delivery option"
      render(:action => 'error')
    end and return
    setup_response = gateway.setup_purchase(current_cart.total_in_cents,
      :ip                   => request.remote_ip,
      :return_url           => confirm_payment_url,
      :cancel_return_url    => cancel_payment_url,
      :allow_guest_checkout => true,
      :items                => current_cart.to_payment_details
    )
     Rails.logger.debug(setup_response.inspect)
    redirect_to gateway.redirect_url_for(setup_response.token)
  end

  def confirm
    redirect_to(root_url) unless params[:token]
    details_response = gateway.details_for(params[:token])

    unless details_response.success?
      @message = details_response.message
      render(:action => 'error')
      return
    end
    @address = details_response.address
    @name = [details_response.params['first_name'], details_response.params['middle_name'], details_response.params['last_name']].compact.join(' ')

    @email_address = details_response.params["payer"]
  end

  def cancel
  end

  def complete
    purchase = gateway.purchase(current_cart.total_in_cents,
      :ip       => request.remote_ip,
      :payer_id => params[:payer_id],
      :token    => params[:token],
      :items    => current_cart.to_payment_details
    )

    unless purchase.success?
      @message = purchase.message
      render(:action => 'error')
      return
    end

    @order = Order.create(
      :cart => current_cart,
      :amount => purchase.params['gross_amount'].to_f,
      :paypal_transaction_id => purchase.params['transaction_id'],
      :paypal_payment_status => purchase.params['payment_status'],
      :buyer_name => params[:buyer],
      :buyer_email => params[:buyer_email],
      :source => cookies['source']
    )
     @cart =  Cart.find(current_cart.id)
    current_cart.update_product_stock
    destroy_session_cart
  end

private

  def gateway
    @gateway ||= PaypalExpressGateway.new(
      :login     => PAYPAL_API_USERNAME,
      :password  => PAYPAL_API_PASSWORD,
      :signature => PAYPAL_API_SIGNATURE
    )
  end
end
