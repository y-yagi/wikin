if Rails.env.development?
  logger = ActiveSupport::Logger.new(File.join(Rails.root, "log", "notifications.log"))
  ActiveSupport::Notifications.subscribe "instantiation.active_record" do |*args|
    event = ActiveSupport::Notifications::Event.new(*args)
    logger.info("[#{event.name}] time: #{event.duration.to_f}  data: #{event.payload.inspect}")
  end

  ActiveSupport::Notifications.subscribe('sql.active_record') do |*args|
    event = ActiveSupport::Notifications::Event.new(*args)
    logger.info("[#{event.name}] time: #{event.duration.to_f}  data: #{event.payload.inspect}")
  end
end
