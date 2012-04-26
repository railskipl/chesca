class Admin::MediasController < Admin::AdminController
  inherit_resources
  def index
    @advertising = Media.advertising
    @advertising_icon = Media.advertising_icon

    @as_seen_in = Media.as_seen_in
    @as_seen_in_icon = Media.as_seen_in_icon

    @events = Media.events
    @events_icon = Media.events_icon

    @videos = Media.videos
    @videos_icon = Media.videos_icon

    @press = Media.press
    @press_icon = Media.press_icon
    index!
  end
  def new
    @media = Media.new
    case params[:type]
    when '1'
      then @media.type_media= 'ADVERTISING'
    when '2'
      then @media.type_media= 'AS SEEN IN'
    when '3'
      then @media.type_media= 'EVENTS'
    when '4'
      then @media.type_media= 'VIDEOS'
    when '5'
      then @media.type_media= 'PRESS'
    end
    if params[:icon]=='true'
      @media.icon = '1'
    else
      @media.icon = '0'
    end
  end
  def create
    if params[:media][:active]=='1'
      if params[:media][:icon]=='1'
        case params[:media][:type_media]
        when "ADVERTISING"
          then medias = Media.active_advertising_icon
        when "AS SEEN IN"
          then medias = Media.active_as_seen_in_icon
        when "EVENTS"
          then medias = Media.active_events_icon
        when "VIDEOS"
          then medias = Media.active_videos_icon
        when "PRESS"
          then medias = Media.active_press_icon
        end
      else
        case params[:media][:type_media]
        when "ADVERTISING"
          then medias = Media.active_advertising
        when "AS SEEN IN"
          then medias = Media.active_as_seen_in
        when "EVENTS"
          then medias = Media.active_events
        when "VIDEOS"
          then medias = Media.active_videos
        when "PRESS"
          then medias = Media.active_press
        end
      end
      medias.each do |m|
        m.active = false
        m.save
      end
    end
    create!{admin_medias_path}
  end
  def update
     if params[:media][:active]=='1'
      if params[:media][:icon]=='1'
        case params[:media][:type_media]
        when "ADVERTISING"
          then medias = Media.active_advertising_icon
        when "AS SEEN IN"
          then medias = Media.active_as_seen_in_icon
        when "EVENTS"
          then medias = Media.active_events_icon
        when "VIDEOS"
          then medias = Media.active_videos_icon
        when "PRESS"
          then medias = Media.active_press_icon
        end
      else
        case params[:media][:type_media]
        when "ADVERTISING"
          then medias = Media.active_advertising
        when "AS SEEN IN"
          then medias = Media.active_as_seen_in
        when "EVENTS"
          then medias = Media.active_events
        when "VIDEOS"
          then medias = Media.active_videos
        when "PRESS"
          then medias = Media.active_press
        end
      end
      new_media=Media.find(params[:id])
      medias = medias-[new_media]
      medias.each do |m|
        m.active = false
        m.save
      end
    end
    update!{admin_medias_path}
  end
end
