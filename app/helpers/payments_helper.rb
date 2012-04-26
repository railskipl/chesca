module PaymentsHelper
  def format_amount_for_webgains(amount)
    number_to_currency(amount, :unit => '', :delimiter => '')
  end

  def webgains_querystring(pairs)
    (pairs.map { |pair| "#{pair.first}=#{@webgains_variables[pair.second]}" }).join('&')
  end

  def webgains_variables(order)
    @webgains_variables ||= {
      :wgOrderValue => format_amount_for_webgains(order.amount),
      :wgOrderReference => URI::escape(order.paypal_transaction_id),
      :wgEventID => '4356',
      :wgComment => '',
      :wgMultiple => '1',

      :wgCustomerID => '',
      :wgProductID => '',
      :wgVoucherCode => URI::escape(''),

      :wgSLang => 'ruby',
      :wgLang => 'en_GB',
      :wgPin => '9814',
      :wgProgramID => '2690',
      :wgVersion => '1.2',
      :wgSubDomain => 'track'
    }

    @webgains_variables[:wgItems] ||= order.cart.cart_items.map do |item|
      "#{@webgains_variables[:wgEventID]}::#{format_amount_for_webgains(item.subtotal)}::#{URI::escape(item.product_name)}::::"
    end.join('|')

    @webgains_variables[:wgCheckString] ||= webgains_querystring([['wgver', :wgVersion], ['wgsubdomain', :wgSubDomain], ['wglang', :wgLang], ['wgslang', :wgSLang], ['wgprogramid', :wgProgramID], ['wgeventid', :wgEventID], ['wgvalue', :wgOrderValue], ['wgorderreference', :wgOrderReference], ['wgcomment', :wgComment], ['wgmultiple', :wgMultiple], ['wgitems', :wgItems], ['wgcustomerid', :wgCustomerID], ['wgproductid', :wgProductID], ['wgvouchercode', :wgVoucherCode]])

    @webgains_variables[:wgCheckSum] ||= Digest::MD5.hexdigest(@webgains_variables[:wgPin] + @webgains_variables[:wgCheckString])

    @webgains_variables[:wgQueryString] ||= @webgains_variables[:wgCheckString] + '&wgchecksum=' + @webgains_variables[:wgCheckSum]

    @webgains_variables[:wgUri] = '://' + @webgains_variables[:wgSubDomain] + '.webgains.com/transaction.html?' + @webgains_variables[:wgQueryString]

    @webgains_variables
  end
  
  def track_order order
    code = ""
    if cookies['source'].present? && cookies['source']!= 'webgains'
      amount = (order.amount) * 0.80
      code = "<img src=\"http://tracking.dc-storm.com/dcv4/loglitepv.aspx?sid=3600&qty=1&val=#{amount}&m1=sale&m2=0&m3=GBP&oid=#{order.id}\"/>"
    end
    code
  end
end

