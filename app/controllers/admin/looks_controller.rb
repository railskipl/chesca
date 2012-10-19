class Admin::LooksController < Admin::AdminController
  inherit_resources
  actions :all
  def index
      @looks = Look.all(:order => 'created_at DESC')
    index!
  end
  def new
    @look = Look.new
  end
end
