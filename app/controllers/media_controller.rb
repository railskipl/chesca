class MediaController < ApplicationController
  def index
    @advertising = Media.active_advertising_icon.first rescue @advertising = nil
    @as_seen_in = Media.active_as_seen_in_icon.first rescue @as_seen_in= nil
    @events = Media.active_events_icon.first rescue @events = nil
    @press = Media.active_press_icon.first rescue @press = nil
    @videos = Media.active_videos_icon.first rescue @videos = nil
  end
  def advertising
    @advertising = Media.active_advertising.first rescue @advertising = nil
  end
  def as_seen_in
    @as_seen_in = Media.active_as_seen_in.first rescue @as_seen_in= nil
  end
  def events
    @events = Media.active_events.first rescue @events = nil
  end
  def press
    @press = Media.active_press.first rescue @press = nil
  end
  def videos
    @videos = Media.active_videos.first rescue @videos = nil
  end
end
