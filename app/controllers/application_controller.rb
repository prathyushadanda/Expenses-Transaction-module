class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :check_user_signed_in, only: "index"
  before_action :authenticate_user!
  rescue_from ::Exception, with: :error_occurred


  def check_user_signed_in
    if current_user.nil?
      redirect_to controller: 'devise/sessions', action: 'new'
    end
  end

  def error_occurred(exception)
    redirect_to :back, :alert => exception.message
  end


end
