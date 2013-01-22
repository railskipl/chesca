class CartItemsController < ApplicationController
 
  def index
    if current_cart.free_delivery? and params[:set_d].nil? #and not current_cart.has_valid_delivery_option?
      current_cart.selected_delivery_option = :free_UK
      current_cart.save
    elsif !current_cart.has_valid_delivery_option?
      current_cart.selected_delivery_option= nil
      current_cart.save
    end
  end

  def create
    params[:cart_item][:size] = Size.find(params[:cart_item][:size]).name rescue params[:cart_item][:size]
    params[:cart_item][:color] = Color.find(params[:cart_item][:color]).name rescue params[:cart_item][:color]
    if params[:cart_item][:quantity].empty?
      params[:cart_item][:quantity] = 1
    else
      params[:cart_item][:quantity] = params[:cart_item][:quantity].to_i rescue params[:cart_item][:quantity] = 1
    end
    @cart_item = current_cart.cart_items.build(params[:cart_item])
    if  current_cart.valid?
      size =Size.find_by_name(params[:cart_item][:size]).id rescue size = nil
      color =Color.find_by_name(params[:cart_item][:color]).id rescue color = nil
      if !size.nil? && !color.nil?
        if ProductSize.find_by_color_id_and_size_id_and_product_id(color,size,params[:cart_item][:product_id])
          current_cart.save!
          if @cart_item.save || @cart_item.errors.empty?
            flash[:notice] = 'The selected product was successfully added to your cart.'
            # @product= Product.find params[:cart_item][:product_id]
            # redirect_to product_path(@product)
            if params[:dept]
            session[:return_to] ||= request.referer
            redirect_to session[:return_to]
            else
            redirect_to cart_items_path
            end
          else
            flash[:error] = 'Something went bad.'
            redirect_to(:back)
          end
        else
          flash[:error] = 'Sorry this combination of Size & Colour is Not Available'
          # @product= Product.find params[:cart_item][:product_id]
          redirect_to cart_items_path
        end
      else
        flash[:error] = 'Sorry this combination of Size & Colour is Not Available'
        # @product= Product.find params[:cart_item][:product_id]
        redirect_to "/"
      end
    else
      flash[:error] = 'Choise an color and size'
      # @product= Product.find params[:cart_item][:product_id]
      redirect_to cart_items_path
    end
  end
 
  def destroy
    @cart_item = current_cart.cart_items.find(params[:id])
    @cart_item.destroy
    if current_cart.cart_items.blank? || (current_cart.free_delivery? and current_cart.selected_delivery_option==Cart.free_delivery)
    current_cart.selected_delivery_option= nil
    current_cart.save
    else

    end
    flash[:notice] = 'The selected item was successfully removed from your cart.'
    redirect_to(cart_items_url,:set_d=>0)
  end

  def add_voucher
    if current_cart.voucher.nil?
      @voucher = Voucher.date_active.find_by_code(params[:code])
      if !@voucher.nil?
        if current_cart.total >= @voucher.amount_off
          current_cart.voucher = @voucher
          current_cart.save
        else
          flash[:error] = "You need to purchase a minimum of #{@voucher.amount_off}£ to use this Voucher."
        end
      end
    end
    render :action => :index,:set_d=>0
  end

  def gift_card_entry
   if current_cart.checks_valid_gift_card_code(params[:code])
     flash[:notice] = 'The selected Giftcard was successfully redeemed from your cart.'
   else
     flash[:error] = 'Invalid Giftcard.'
   end
    render :action => :index,:set_d=>0
  end

  def disjoin_voucher
    current_cart.voucher = nil
    current_cart.save
    render :action => :index
  end

  def remove_giftcard
    current_cart.giftcard = nil
    current_cart.save
    render :action => :index 
  end
  
  def select_delivery_option
    current_cart.selected_delivery_option= params[:delivery_option].blank? ? nil : params[:delivery_option].to_sym
    current_cart.save
    redirect_to :action => :index,:set_d=>0
  end

end