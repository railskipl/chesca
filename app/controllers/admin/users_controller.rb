class Admin::UsersController < Admin::AdminController
  inherit_resources
   def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.csv do
        Rails.logger.debug request.protocol

        generated_csv = FasterCSV.generate do |csv|
          csv << ["User ID", "Name", "Email"]

          @users.each do |p|
            csv << [
              p.id,
              p.name,
              p.email,
              'Chesca'
            ]
          end
        end
        send_data generated_csv, :type => 'text/csv; charset=iso-8859-1; header=present', :disposition => "attachment; filename=users.csv"
      end
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        Mailer.deliver_registration_confirmation(@user)
        format.html { redirect_to( admin_users_path, :notice => 'User was successfully created.') }
        format.xml  { render :xml => @user, :status => :created, :location => admin_users_path }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => admin_users_path.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(admin_users_path) }
      format.xml  { head :ok }
    end
  end
end
