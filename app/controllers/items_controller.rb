class ItemsController < ApplicationController
  def index
    # ダミーデータを設定する例
    @items = [
      OpenStruct.new(name: "商品1", price: 1000, image_url: "sample_image_1.jpg", sold_out: false),
      OpenStruct.new(name: "商品2", price: 2000, image_url: "sample_image_2.jpg", sold_out: true)
    ]
  end
end
