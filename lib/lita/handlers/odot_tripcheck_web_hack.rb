module Lita
  module Handlers
    class OdotTripcheckWebHack < Handler

      route(/^tripcheck\s+(.*)/i, :handle_tripcheck, command: true,
            help: { 'tripcheck 35' => 'Displays an image of hwy 26 @ hwy 35'})

      def handle_tripcheck(response)
        input = response.matches[0][0]
        Lita.logger.debug "Looking for '#{input}'"

        uri_base = 'https://tripcheck.com/RoadCams/cams/'
        cameras = {
            # 'Hood River': %w(Hood%20River%20Exit%2064a_pid1863.JPG Hood%20River%20Exit%2063_pid1860.JPG),
            'Hood River': 'Hood%20River%20Exit%2064a_pid1863.JPG',
            '26 at 35': 'US26%20at%20Hwy35_pid1881.JPG',
            '26 at Snow Bunny': 'US26%20at%20Snow%20Bunny_pid1887.JPG',
            # '26 at Govy': %w(GovernmentCamp_pid624.jpg US26%20at%20Govn%20Camp%20Maint_pid1899.JPG),
            '26 at Govy': 'US26%20at%20Govn%20Camp%20Maint_pid1899.JPG',
            '26 at Govy Loop Rd': 'US26%20at%20Govt%20Camp%20Lp%20Rd_pid1776.JPG',
            '26 at Frog Lake': 'US26%20at%20Frog%20Lake%20VMS_pid1773.JPG',
            '26 at Blue Box Pass': 'Blue%20Box%20Pass_pid1919.JPG'
        }

        cameras.keys.each do |camera_key|
          Lita.logger.debug "Trying to match '#{input.downcase}' to '#{camera_key.downcase}'"
          if camera_key.to_s.downcase.include? input.downcase
            response.reply "#{uri_base}#{cameras[camera_key]}?rand=#{Time.now.to_i}123"
            return   # Quick exit.
          end
        end
      end

    end
    Lita.register_handler(OdotTripcheckWebHack)
  end
end
