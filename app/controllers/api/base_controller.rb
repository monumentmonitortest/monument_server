module Api
  class BaseController < ActionController::API
    include ActionController::Serialization
    include ActionController::HttpAuthentication::Token::ControllerMethods

    # before_action :authenticate

    protected

      def authenticate
        authenticate_token || render_unauthorized
      end

      def authenticate_token
        authenticate_with_http_token do |token, options|
          token == ENV["API_TOKEN"]
        end
      end
    
      def render_unauthorized(realm = "Application")
        self.headers["WWW-Authenticate"] = %(Token realm="#{realm}")
        render json: 'oooh noooo, looks like you have some Bad Credentials', status: :unauthorized
      end
  end
end