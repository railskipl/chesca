module Admin::ImagepagesHelper
  def root_url_app
    return root_url.delete "/^"
  end
end
