class Saving < ActiveRecord::Base
  attr_accessible :date, :price

  def self.sum
    sum = 0
    Saving.all.each do |saving|
      sum += saving.price
    end
    sum

  end
end
