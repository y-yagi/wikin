if Rails.env.development?
  ActiveSupport::Notifications.subscribe "instantiation.active_record" do |name, started, finished, unique_id, data|
    Rails.logger.info("[Notifications #{name}] time: #{(finished - started).to_f}  data: #{data.inspect}")
  end

  ActiveSupport::Notifications.subscribe "sql.active_record" do |name, started, finished, unique_id, data|
    Rails.logger.info("[Notifications #{name}] time: #{(finished - started).to_f}  data: #{data.inspect}")
  end
end
