module EnToZh
  module Translate
    extend ActiveSupport::Concern
 
    included do
    end
 
    module ClassMethods
      def translate(name)
        appKey = Rails.application.credentials.dig(:youdao_appKey)
        secretKey = Rails.application.credentials.dig(:youdao_secretKey)
        q, from, to, salt, myurl = name, 'EN', 'zh-CHS', Random.rand(10000).to_s, 'https://openapi.youdao.com/api'
        sign = Digest::MD5.hexdigest(appKey+q+salt+secretKey).upcase
        url = URI.escape(myurl+"?q="+q+"&from="+from+"&to="+to+"&appKey="+appKey+"&salt="+salt+"&sign="+sign)
      begin
        response = HTTParty.get(url)
      rescue SocketError
        response = "net_error"
      end
      end
    end
  end
end
