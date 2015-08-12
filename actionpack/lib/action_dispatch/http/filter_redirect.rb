module ActionDispatch
  module Http
    module FilterRedirect

      FILTERED = '[FILTERED]'.freeze # :nodoc:

      def filtered_location # :nodoc:
        filters = location_filter
        if !filters.empty? && location_filter_match?(filters)
          FILTERED
        else
          location
        end
      end

    private

      def location_filter
        if request
          request.env['action_dispatch.redirect_filter'] || []
        else
          []
        end
      end

      def location_filter_match?(filters)
        filters.any? do |filter|
          if String === filter
            location.include?(filter)
          elsif Regexp === filter
            location =~ filter
          end
        end
      end

    end
  end
end
