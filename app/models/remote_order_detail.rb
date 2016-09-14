class RemoteOrderDetail < RemoteDB

  self.table_name  = ENV['ORDER_DETAIL_TABLE_NAME']
  self.primary_key = ENV['ORDER_DETAIL_PRIMARY_KEY']

  alias_attribute :id,       ENV['ORDER_DETAIL_ID']
  alias_attribute :order_id, ENV['ORDER_DETAIL_ORDER_ID']

  belongs_to :remote_order,   foreign_key: ENV['ORDER_DETAIL_ORDER_ID']
  belongs_to :remote_product, foreign_key: ENV['ORDER_DETAIL_PRODUCT_ID']

end
