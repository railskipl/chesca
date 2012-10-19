class Admin::DepartmentsController < Admin::AdminController
  inherit_resources
  actions :all, :except => :show

  def index
    @new_department = Department.new
    index!
  end
  
  def new
    @parent_id = params[:id]
    @parents = parents(params[:id])
    @department =Department.new
  end
  
  def create
    if params[:parent_id]!= ""
      if parent = Department.find(params[:parent_id])
        parent.children.create(params[:department])
        redirect_to admin_departments_path
      end
    else
    create! { admin_departments_url }
    end
  end
  
  def update
    update! { admin_departments_url }
  end
  
  private
  
  def parents(id_category)
    category =Department.find(id_category)
    parents =[category.name]
    while !category.parent.nil?
        category = category.parent
        parents.push category.name
    end
    return parents.reverse
  end
end