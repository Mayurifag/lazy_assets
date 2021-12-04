class Exchange < ApplicationRecord
  def moscow?
    mic == "MISX"
  end
end
