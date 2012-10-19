class FooterpagesController < ApplicationController
   inherit_resources
   actions :show  
    
   def show
     @footerpage = Footerpage.find(params[:id])
   end
   
end
