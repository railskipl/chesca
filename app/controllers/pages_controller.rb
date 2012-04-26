class PagesController < ApplicationController

  inherit_resources
  actions :show
  before_filter :set_title

  def set_title
    @title = resorce.name rescue "Pages"
    @meta_title = resource.name
    @fb_meta[:title] = resource.name
    @fb_meta[:image] =   resource.image.url(:large) unless resource.image.url(:large).include?("missing")
  end

end
