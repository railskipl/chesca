# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def google_analytics
    render :partial => 'layouts/google_analytics', :locals => { :tracking_code => ENV['GOOGLE_ANALYTICS_TRACKING_CODE'] } if ENV['GOOGLE_ANALYTICS_TRACKING_CODE']
  end
  def csrf_meta_tag
    if protect_against_forgery?
      out = %(<meta name="csrf-param" content="%s"/>\n)
      out << %(<meta name="csrf-token" content="%s"/>)
      out % [ Rack::Utils.escape_html(request_forgery_protection_token),
              Rack::Utils.escape_html(form_authenticity_token) ]
    end
  end
  def url_to_location_real(location)
    if location.new_record?
      admin_locations_path
    else
      admin_location_path(location)
    end
  end

  def active_news_feeds
    @active_feeds_to_show ||= (NewsFeed.active||[]).map(&:text)
  end

  def inplace_edit_field(options={})
    options[:content] = { :element => 'span' }.merge(options[:content])
    options[:url] = options[:url] || ""
    options[:ajax] = { :okText => 'Save', :cancelText => 'Cancel'}.merge(options[:ajax] || {})
    script = Array.new
    script << "new Ajax.InPlaceEditor("
    script << "  '#{options[:content][:id]}',"
    script << "  '#{options[:url]}',"
    script << "  {"
    script << options[:ajax].map{ |key, value| "#{key.to_s}: '#{value}'" }.join(", ")
    script << "  }"
    script << ")"

    content_tag(
      options[:content][:element],
      options[:content][:text],
      {:id=>options[:content][:id]}
    ) + javascript_tag( script.join("") )
  end
  
    



  def facebook_like(url_share="", action = "recommend")
    return "" if(@facebook_rendered)
    @facebook_rendered = true
    %{<div id="fb-root"></div>
<script>(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) {return;}
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_US/all.js#appId=#{ENV["fb_app_id"]}&xfbml=1";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));</script>
<fb:like href="#{URI.escape(url_share, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))}" send="false" width="360" show_faces="false" action="#{action}"></fb:like>
    }
  end

  def facebook_meta options={}
    opt = {
      :title => "#{META_DESCRIPTION} | #{@meta_title}",
      :type=> "product",
      :image=>"#{root_url  :only_path=>false}images/chesca-logo.png",
      :sitename=> "Chesca",
      :url => request.url,
      :admin => ENV["fb_app_admin_id"],
      :description => @meta_description || META_DESCRIPTION
    }.merge(options)
    %{
   <meta property="og:title" content="#{opt[:title]}" />
   <meta property="og:type" content="#{opt[:type]}" />
   <meta property="og:image" content="#{opt[:image]}" />
   <meta property="og:site_name" content="#{opt[:sitename]}" />
   <meta property="fb:admins" content="#{opt[:admin]}" />
   <meta property="og:url" content="#{opt[:url]}" />
   <meta property="og:description" content="#{opt[:description]}" />
    }
  end

  def meta_tags
    render :partial => 'layouts/meta_tags'
  end

  def tracking_campaign_kissmetrics
    if defined?(@render_cookie) && @render_cookie
      "_kmq.push(['set', {'Campaign Source':#{cookies['source']}}]);"
    end
  end

  def tracking_amount_kissmetrics(amount)
    "_kmq.push(['set', {'Billing Amount':#{amount}}]);"
  end

  def tracking_email_kissmetrics(email)
    "_kmq.push(['identify', '#{email}']);"
  end
end

