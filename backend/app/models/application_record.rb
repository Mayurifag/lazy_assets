class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  nilify_blanks
  include TranslateEnum

  def self.named_enum(attr, array = [], **options)
    enum(attr => array.to_h { |item| [item, item] }, **options)
  end
end
