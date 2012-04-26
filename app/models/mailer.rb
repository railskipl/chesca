class Mailer < ActionMailer::Base
  def send_to_a_friend(name, email, friends_email, product, sent_at = Time.now)
    from        %("#{name}" <#{email}>)
    recipients  friends_email
    subject     "#{name} wants to recommend you this product"
    sent_on     sent_at
    body        :name => name, :product => product
  end

  def contact_us(name, email, message, sent_at = Time.now)
    from        %("#{name}" <#{email}>)
    recipients  'info@chesca1424.co.uk'
    subject     'Chesca Contact Form'
    sent_on     sent_at
    body        :name => name, :message => message
  end

  def returns(name, email, order_number, comments, sent_at = Time.now)
    from        %("#{name}" <#{email}>)
    recipients  'info@chesca1424.co.uk'
    subject     'Returns'
    sent_on     sent_at
    body        :name => name, :order_number => order_number, :comments => comments
  end
end

