module OmniAuth
  module Strategies
    class Keyrock < OmniAuth::Strategies::OAuth2
      include OmniAuth::Strategy
      option :name, "keyrock" # strategyの名前ここで指定した名前をdeviseで呼び出す
      option :client_options, {
        site: 'http://keyrock:3001',
        authorize_url: 'http://localhost:3001/oauth2/authorize',
        token_url: 'http://keyrock:3001/oauth2/token',
      #  ssl: { verify: false } 
      }

      # uidとして設定するデータを指定
      uid { raw_info['id'] }
      # providerから送られてきたデータの内、どれを使いたいか
      info do
        { 
          email: raw_info['email'],
          name: raw_info['username'],
          provider: "keyrock"
         }
      end

      # providerのAPIを叩いて、データを取ってくる
      def raw_info
        p '------cool raw_info --------'
        @raw_info ||= access_token.get('/user').parsed
        p @raw_info
      end

      # リクエストにカスタムパラメータを追加
      def request_phase
        p '------cool request_phase --------'
        p callback_url
        _authorize_params = { :redirect_uri => callback_url }.merge(authorize_params)
     #   _authorize_params.merge!({ group_id: request.env['omniauth.params']['group_id'] })
        redirect client.auth_code.authorize_url({:redirect_uri => callback_url}.merge(authorize_params))
        puts _authorize_params
        super
      end
    
      # リダイレクトURLを固定（デフォルトではクエリパラメータが付加されるため）
      def callback_url
        #full_host + script_name + callback_path
        "http://localhost:3000/users/auth/keyrock/callback"
      end
    end
  end
end