class Admin::FooterpagesController < Admin::AdminController
  inherit_resources
  actions :all
  
  def index
      @footerpages = Footerpage.all(:order => 'created_at DESC')
    index!
  end
  
  def new
    @footerpage = Footerpage.new
  end
  
end
