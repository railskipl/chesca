class Admin::PrivacyPoliciesController < Admin::AdminController
  inherit_resources
  def create
    if params[:privacy_policy][:active]=true
      privacy_policies = PrivacyPolicy.active
      privacy_policies.each do |pp|
        pp.active = false
        pp.save
      end
    end
    create!{admin_privacy_policies_path}
  end
  def update
    if params[:privacy_policy][:active]=true
      new_pp=PrivacyPolicy.find(params[:id])
      privacy_policies = PrivacyPolicy.active
      privacy_policies = privacy_policies-[new_pp]
      privacy_policies.each do |pp|
        pp.active = false
        pp.save
      end
    end
    update! {admin_privacy_policies_path}
  end
end
