class Admin::StylesController < Admin::AdminController
  inherit_resources
  actions :all, :except => :show
  def index
    @new_style = Style.new
    index!
  end
  def new
    @parent_id = params[:id]
    @parents = parents(params[:id])
    @style =Style.new
  end

  def create
    if params[:parent_id]!= ""
      if parent = Style.find(params[:parent_id])
        parent.children.create(params[:style])
        redirect_to admin_styles_path
      end
    else
    create! { admin_styles_url }
    end
  end

  def update
    update! { admin_styles_url }
  end
  private
  def parents(id_category)
    category =Style.find(id_category)
    parents =[category.name]
    while !category.parent.nil?
        category = category.parent
        parents.push category.name
    end
    return parents.reverse
  end
end
