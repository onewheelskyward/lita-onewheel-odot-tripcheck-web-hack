require 'httparty'
require 'nokogiri'

module Lita
  module Handlers
    class OdotTripcheckWebHack < Handler

      route(/^!tripcheck\s+(.*)/i, :handle_tripcheck)

      def handle_tripcheck(response)
        input = response.matches[0][0]

        response.reply 'x'
      end

    Lita.register_handler(OdotTripcheck)
  end
end
