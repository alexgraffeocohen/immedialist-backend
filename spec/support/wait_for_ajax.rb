module WaitForAjax
  def wait_for_ajax(max_wait_time = 30)
    timeout(max_wait_time) do
      while pending_ajax_requests?
        sleep 0.1
      end
    end
  end

  def pending_ajax_requests?
    page.driver.network_traffic.collect(&:response_parts).any?(&:empty?)
  end
end
