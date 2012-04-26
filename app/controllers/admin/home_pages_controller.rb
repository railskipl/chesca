class Admin::HomePagesController < Admin::AdminController
  inherit_resources
  def create
    if params[:home_page][:active]=='true'
      home_pages = HomePage.active
      home_pages.each do |hp|
        hp.active = false
        hp.save
      end
    end
    create!{ admin_home_pages_path}
  end
  def update
     if params[:home_page][:active]== 'true'
      new_hp=HomePage.find(params[:id])
      home_pages = HomePage.active
      home_pages = home_pages-[new_hp]
      home_pages.each do |hp|
        hp.active = false
        hp.save
      end
    end
    update!{admin_home_pages_path}
  end
end
