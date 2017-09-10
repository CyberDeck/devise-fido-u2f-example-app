HighVoltage.configure do |config|
  # Disable default routes because of our own page controller(s)
  config.routes = false
end
