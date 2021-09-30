class BaseInteractor
  include AfterCommitEverywhere

  def self.call(...)
    new.call(...)
  end

  def self.validate_input(contract:)
    step :validate_input

    define_method(:validate_input) do |input|
      contract.validate_input(input)
    end
  end
end
