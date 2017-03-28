class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :auth

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname,:year,:group_id,:image])
    devise_parameter_sanitizer.permit(:account_update, keys: [:year,:group_id,:image])
  end

      def auth
      name = 'surajan'
      passwd = '2017'
      authenticate_or_request_with_http_basic('book')do |n,p|
      n == name && p == passwd
      end
      end
end
