require "dry/transaction/operation"

class BaseContract < Dry::Validation::Contract
  include Dry::Transaction::Operation

  config.messages.backend = :i18n

  def self.validate_input(input)
    new.validate_input(input)
  end

  def validate_input(input)
    result = self.class.new.call(input)

    result.success? ? Success(result.to_h) : Failure(input.merge(errors: result.errors.to_h))
  end
end
