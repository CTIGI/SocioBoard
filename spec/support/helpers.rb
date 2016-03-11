RSpec.configure do |config|
  config.include Module.new {
    def t(*args, &block)
      I18n.t(*args, &block)
    end

    def l(*args, &block)
      I18n.l(*args, &block)
    end
  }
end
