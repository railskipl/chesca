class Admin::LooksController < Admin::AdminController
  inherit_resources
  actions :all, :excepts => :show
  def index
    @new_look = Look.new
    index!
  end
  def new
    @parent_id = params[:id]
    @parents = parents(params[:id])
    @look =Look.new
  end
  def create
    if params[:parent_id]!= ""
      if parent = Look.find(params[:parent_id])
        parent.children.create(params[:look])
        redirect_to admin_looks_path
      end
    else
    create! { admin_looks_url }
    end
  end
  def update
    update! { admin_looks_url }
  end
  private
  def parents(id_category)
    category =Look.find(id_category)
    parents =[category.name]
    while !category.parent.nil?
        category = category.parent
        parents.push category.name
    end
    return parents.reverse
  end
end

