class BaseContainer
  extend Dry::Container

  register "transaction" do |input, &block|
    result = nil

    ActiveRecord::Base.transaction do
      result = block.call(Success(input))
      raise ActiveRecord::Rollback if result.failure?
    end

    result
  end
end
