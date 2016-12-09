module Lita
  module Handlers
    class OnewheelOdotTripcheckWebHack < Handler

      route(/^tripcheck\s+(.*)/i, :handle_tripcheck, command: true,
            help: { 'tripcheck 35': 'Displays an image of hwy 26 @ hwy 35'})

      route(/^tripcheck$/i, :handle_tripcheck_list, command: true,
            help: { 'tripcheck': 'Display a list of tripcheck cameras covered.'})

      route(/^sandycam$/i, :handle_sandycam, command: true)

      def get_cameras
        uri_base = 'https://tripcheck.com/RoadCams/cams/'

        {
          # 'Hood River': %w(Hood%20River%20Exit%2064a_pid1863.JPG Hood%20River%20Exit%2063_pid1860.JPG),
          'Hood River': uri_base + 'Hood%20River%20Exit%2064a_pid1863.JPG',
          '26 at 35': uri_base + 'US26%20at%20Hwy35_pid1881.JPG',
          '26 at Snow Bunny': uri_base + 'US26%20at%20Snow%20Bunny_pid1887.JPG',
          # '26 at Govy': %w(GovernmentCamp_pid624.jpg US26%20at%20Govn%20Camp%20Maint_pid1899.JPG),
          '26 at Govy': uri_base + 'US26%20at%20Govn%20Camp%20Maint_pid1899.JPG',
          '26 at Govy Loop Rd': uri_base + 'US26%20at%20Govt%20Camp%20Lp%20Rd_pid1776.JPG',
          '26 at Frog Lake': uri_base + 'US26%20at%20Frog%20Lake%20VMS_pid1773.JPG',
          '26 at Blue Box Pass': uri_base + 'Blue%20Box%20Pass_pid1919.JPG',
          'Sandy Blvd in Hollywood': 'https://launchpad.pin13.net/cam/sandy.jpg'
        }
      end

      def handle_sandycam(response)
        Lita.logger.debug "SANDYCAM"
        response.reply get_camera_url('sandy')
      end

      def handle_tripcheck(response)
        input = response.matches[0][0]
        Lita.logger.debug "Looking for '#{input}'"

        response.reply get_camera_url(input)
      end

      def get_camera_url(input)
        get_cameras.keys.each do |camera_key|
          Lita.logger.debug "Trying to match '#{input.downcase}' to '#{camera_key.downcase}'"
          if camera_key.to_s.downcase.include? input.downcase
            image = get_cameras[camera_key]
            unless camera_key.to_s == 'Sandy Blvd in Hollywood'
              image += "?rand=#{Time.now.to_i}123"
            end

            return image
          end
        end
      end

      def handle_tripcheck_list(response)
        Lita.logger.debug "Replying with: Cameras available include: #{get_cameras.keys.join ', '}"
        response.reply "Cameras available include: #{get_cameras.keys.join ', '}"
      end

    end
    Lita.register_handler(OnewheelOdotTripcheckWebHack)
  end
end
