class Chef
    class DataCollector
      class Reporter < EventDispatch::Base
        private
        def send_to_data_collector(message)
          #return unless data_collector_accessible?
          IO.write('/hab/svc/kiosk_hostConfig/output/converge-status.json', JSON.generate(message))
          #http.post(nil, message, headers)
        end
      end
    end
  end