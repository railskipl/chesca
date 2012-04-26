class Admin::ColorProductsController < Admin::AdminController
  inherit_resources
  actions :all, :except => [:show, :index, :new, :edit]
end
