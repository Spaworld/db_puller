class Product < RemoteDB

  self.table_name   = ENV['PRODUCTS_TABLE_NAME']
  self.primary_key  = ENV['PRODUCTS_PRIMARY_KEY']

  has_many :order_details, foreign_key: ENV['ORDER_DETAIL_PRODUCT_ID']

end