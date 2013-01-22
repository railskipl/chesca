class MainController < ApplicationController
  layout "pinkapplication"
  def index
  #  @occasion = Style.find_by_name('Occasion')
  #  @evening = Style.find_by_name('Evening')
  #  @jerseys = Department.find_by_name('Jerseys')
    @home_page = HomePage.active.first
  end
  
  def test
    
  end
end
