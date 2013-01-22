class StaticController < ApplicationController
  layout :layout_by_resource
  attr_reader :locations, :sizing_chart
  
  
  def layout_by_resource
    if params[:action] == 'locations'
      "pinkapplication"
    else
      "application"
    end
  end
  def returns
    if request.post?
      if validate_mailer_params(params[:mailer])
        Mailer.deliver_returns(params[:mailer][:name], params[:mailer][:email], params[:mailer][:order_number], params[:mailer][:comments])
        flash[:notice] = 'Thank you! Your message has been sent, you will receive a reply briefly.'
      end

      redirect_to root_url
    end
  end

  def contact_us
    if request.post?
      if validate_mailer_params(params[:mailer])
        Mailer.deliver_contact_us(params[:mailer][:name], params[:mailer][:email], params[:mailer][:message])
        flash[:notice] = 'Thank you! Your message has been sent, you will receive a reply briefly.'
      end

      redirect_to root_url
    end
  end

  def locations
    @areas = Location.all(:include => :addresses)
  end
  
  def site_map
    @looks = Look.parent_look
    @categories = Department.parent_category
    @boutiques = Style.parent_boutique
    @designers = Designer.all
  end
  def privacy_policy
    @privacy_policy = PrivacyPolicy.find_by_active(true)
  end
  def our_company
    require 'nokogiri'
    @our_company = OurCompany.find_by_active(true)
    @links = []
    unless @our_company.nil?
      doc = Nokogiri::HTML(@our_company.content)
      doc.css('h2').each do |h2|
        aux =  h2.inner_text.to_s.gsub(/\r\n\t/, '') rescue ''
        aux = aux.strip
        unless aux.empty?
          @links << aux.capitalize
        end
      end
    end
  end
  def ask_us
  end
private

  def validate_mailer_params(params)
    params.values.all? { |param| !param.blank? } && valid_name?(params[:name]) && valid_email_address?(params[:email])
  end

end
