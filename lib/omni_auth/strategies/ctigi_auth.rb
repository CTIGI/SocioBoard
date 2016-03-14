require "omniauth-oauth2"

module OmniAuth
  module Strategies
    class CtigiAuth < OmniAuth::Strategies::OAuth2
      option :name, "ctigi_auth"
      option :client_options, {
        site:          Figaro.env.ctigi_auth_app_url,
        authorize_url: "/oauth/authorize"
      }

      uid { raw_info["user"]["ctigi_auth_uid"] }

      info do
        {
          email: raw_info["user"]["email"]
        }
      end

      extra do
        { raw_info: raw_info }
      end

      def raw_info
        raw_info ||= access_token.get("/api/v1/credentials/me").parsed
      end

      def callback_url
        super
      end
    end
  end
end
