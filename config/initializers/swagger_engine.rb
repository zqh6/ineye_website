SwaggerEngine.configure do |config|
  config.admin_username = '123'
  config.admin_password = '123123'

  config.json_files = {
    '银海官网公用 API': 'lib/swagger/all_api.json'
  }
end