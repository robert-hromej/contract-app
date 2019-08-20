class BaseService
  class Success
    attr_reader :data

    def initialize(data)
      @data = data
    end

    def success?
      true
    end
  end

  class Error
    attr_reader :error

    def initialize(error)
      @error = error
    end

    def success?
      false
    end
  end

  def call; end

  def success?; end
end
