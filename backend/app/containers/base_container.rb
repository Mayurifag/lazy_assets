class BaseContainer
  extend Dry::Container::Mixin
  extend Dry::Monads::Result::Mixin

  register "transaction" do |input, &block|
    result = nil

    ActiveRecord::Base.transaction do
      result = block.call(Success(input))
      raise ActiveRecord::Rollback if result.failure?
    end

    result
  end
end
