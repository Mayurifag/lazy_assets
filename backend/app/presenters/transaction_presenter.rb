module TransactionPresenter
  # I consider this shouldn't be metaprogrammed
  def total_price_presented
    Money.new(total_price_in_cents, currency).format
  end

  def total_price_commission_presented
    return "-" if total_price_commission_in_cents.zero?

    Money.new(total_price_commission_in_cents, currency).format
  end

  def accured_interest_presented
    return "-" if accured_interest_in_cents.blank? || accured_interest_in_cents.zero?

    Money.new(accured_interest_in_cents, currency).format
  end

  def price_for_one_asset_presented
    return "-" if price_for_one_asset_in_cents.zero?

    Money.new(price_for_one_asset_in_cents, currency).format
  end
end
