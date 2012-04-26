class Admin::VouchersController < Admin::AdminController
  inherit_resources
  def index
    @vouchers = Voucher.all
  end

  def create
    create! { admin_vouchers_path }
  end

  def update
    update! { admin_vouchers_path }
  end
end
