class Admin::BaseController < ApplicationController


  private

   def authenticate_admin
     unless current_user.admin?
       flash[:alert] = "What?"
       redirect_to root_path
     end
   end

end