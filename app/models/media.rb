class Media < ActiveRecord::Base
  named_scope :advertising, :conditions => {:type_media => 'ADVERTISING', :icon => false}
  named_scope :as_seen_in, :conditions => {:type_media => 'AS SEEN IN', :icon => false}
  named_scope :events, :conditions => {:type_media => 'EVENTS', :icon => false}
  named_scope :videos, :conditions => {:type_media => 'VIDEOS', :icon => false}
  named_scope :press, :conditions => {:type_media => 'PRESS', :icon => false}

  named_scope :advertising_icon, :conditions => {:type_media => 'ADVERTISING', :icon => true}
  named_scope :as_seen_in_icon, :conditions => {:type_media => 'AS SEEN IN', :icon => true}
  named_scope :events_icon, :conditions => {:type_media => 'EVENTS', :icon => true}
  named_scope :videos_icon, :conditions => {:type_media => 'VIDEOS', :icon => true}
  named_scope :press_icon, :conditions => {:type_media => 'PRESS', :icon => true}

  named_scope :active_advertising_icon, :conditions => ['active = ? && type_media = ? && icon = ?',true, 'ADVERTISING',true]
  named_scope :active_as_seen_in_icon, :conditions => ['active = ? && type_media = ? && icon = ?',true, 'AS SEEN IN',true]
  named_scope :active_events_icon, :conditions => ['active = ? && type_media = ? && icon = ?',true, 'EVENTS',true]
  named_scope :active_videos_icon, :conditions => ['active = ? && type_media = ? && icon = ?',true, 'VIDEOS',true]
  named_scope :active_press_icon, :conditions => ['active = ? && type_media = ? && icon = ?',true, 'PRESS',true]

  named_scope :active_advertising, :conditions => ['active = ? && type_media = ? && icon NOT LIKE ?',true, 'ADVERTISING',true]
  named_scope :active_as_seen_in, :conditions => ['active = ? && type_media = ? && icon NOT LIKE ?',true, 'AS SEEN IN',true]
  named_scope :active_events, :conditions => ['active = ? && type_media = ? && icon NOT LIKE ?',true, 'EVENTS',true]
  named_scope :active_videos, :conditions => ['active = ? && type_media = ? && icon NOT LIKE ?',true, 'VIDEOS',true]
  named_scope :active_press, :conditions => ['active = ? && type_media = ? && icon NOT LIKE ?',true, 'PRESS',true]

  #attr_accessible :title,:media_file_name, :content, :type, :icon, :active
  has_attached_file :media, :styles => {:tiny => '89x195',:icon => '260x214'}
  validates_attachment_content_type :media, :content_type => ['image/jpeg', 'image/png', 'image/gif']
end
