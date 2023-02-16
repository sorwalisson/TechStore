class ApplicationController < ActionController::Base
  def msg_not_admin
    render json: {error: "Only admins may access this fuction"}
  end
  
  def check_admin
    return msg_not_admin() unless current_user.admin?
  end
end
