class UsersController < ApplicationController
  # GET /users
  # GET /users.xml
 layout 'application'
  def index
    redirect_to root_path
  end

  # GET /users/1
  # GET /users/1.xml
  def show
   redirect_to root_path
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    redirect_to root_path
  end

  # POST /users
  # POST /users.xml
  def create
    if params[:user][:email].present?
      @user = User.new(params[:user])
  
      respond_to do |format|
        if @user.save
          Mailer.deliver_registration_confirmation(@user)
          format.html { redirect_to(root_path, :notice => 'Thank You For Registering to our mailing list!') }
          # format.xml  { render :xml => @user, :status => :created, :location => @user }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
        end
      end
    else
      redirect_to :back
      flash[:notice] = 'Email Can Not Be Blank.'
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
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
end
