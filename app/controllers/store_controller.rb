class StoreController < ApplicationController
  def index
  	@products = Product.order(:title) # вызов метода order(:title) модели Product  - перечень в алфавитном порядеке
  end
end
