class Admin::OurCompaniesController < Admin::AdminController
  inherit_resources
  def create
    if params[:our_company][:active]=true
      our_companies = OurCompany.active
      our_companies.each do |oc|
        oc.active = false
        oc.save
      end
    end
    create!{admin_our_companies_path}
  end
  def update
    if params[:our_company][:active]=true
      new_oc=OurCompany.find(params[:id])
      our_companies = OurCompany.active
      our_companies = our_companies-[new_oc]
      our_companies.each do |oc|
        oc.active = false
        oc.save
      end
    end
    update! {admin_our_companies_path}
  end
end
