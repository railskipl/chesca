class Admin::GiftcardsController < Admin::AdminController
  inherit_resources
  actions :all, :except => :show
  def index
    @giftcards = Giftcard.all
    @new_giftcard = Giftcard.new
  end
  def create
    create! {admin_giftcards_path}
  end
  def update
    update! {admin_giftcards_path}
  end
end
