class Admin::OrdersController < Admin::AdminController
  inherit_resources
  
  def index
    @orders = Order.find(:all)
   
    respond_to do |format|
      format.html
      format.csv do
        Rails.logger.debug request.protocol

        generated_csv = FasterCSV.generate do |csv|
          csv << ["Cart ID", "Amount","Paypal Transaction Id","Paypal Payment status", "Buyer Name","Source","Buyer email"]

          @orders.each do |p|
            csv << [
              p.cart_id,
              p.amount,
              p.paypal_transaction_id,
              p.paypal_payment_status,
              p.buyer_name,
              p.source,
              p.buyer_email
            ]
          end
        end
        send_data generated_csv, :type => 'text/csv; charset=iso-8859-1; header=present', :disposition => "attachment; filename=orders.csv"
      end
    end
  end
end
