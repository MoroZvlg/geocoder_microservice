logerdev = Application.environment == :production ? STDOUT : Application.root.concat("/", Settings.logger.path)

Application.configure do |app|
  logger = Ougai::Logger.new(
      logerdev,
      level: Settings.logger.level
  )

  logger.before_log = lambda do |data|
    data[:service] = { name: Settings.app.name }
    data[:request_custom_data] ||= { id: Thread.current[:request_id] }
  end
  app.set :logger, logger
end

# Application.configure :development do |app|
#   logger.formatter = Ougai::Formatters::Readable.new
# end
