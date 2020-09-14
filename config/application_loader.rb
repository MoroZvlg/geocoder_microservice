module ApplicationLoader
  extend self

  def load_app!
    init_settings
    require_lib
    require_app
    init_app
  end

  def init_settings
    require_file 'config/initializers/config.rb'
  end

  def root
    File.expand_path('..', __dir__)
  end

  private

  def init_app
    require_dir 'config/initializers'
  end

  def require_lib
    require_dir 'lib/'
    require_dir 'app/lib/'
  end

  def require_app
    require_file 'app/helpers/validations'
    require_dir 'app/helpers'
    require_file 'config/application'
    require_dir 'app/', pattern: "application*.rb"
    require_dir 'app/'
  end

  def require_file(path)
    require File.join(root, path)
  end

  def require_dir(path, pattern: "*.rb")
    path = File.join(root, path)
    Dir["#{path}**/#{pattern}"].each {|file| require file }
  end
end