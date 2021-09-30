class TransactionsRepository
  def create(input)
    klass.create(input)
  end

  private

  def klass
    Transaction
  end
end
