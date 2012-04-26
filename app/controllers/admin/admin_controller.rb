class Admin::AdminController < ApplicationController
  before_filter :require_authentication
  layout 'admin'
end
