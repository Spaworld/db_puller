class Order < RemoteDB

  self.table_name  = ENV['ORDERS_TABLE_NAME']
  self.primary_key = ENV['ORDERS_PRIMARY_KEY']

  alias_attribute :id,          ENV['ORDERS_PRIMARY_KEY']
  alias_attribute :created_at,  ENV['ORDERS_DATE']
  alias_attribute :type,        ENV['ORDERS_TYPE']
  alias_attribute :channel_id,  ENV['ORDERS_CUSTOMER_ID']
  alias_attribute :return?,     ENV['ORDERS_RETURN']
  alias_attribute :total,       ENV['ORDERS_TOTAL']

  default_scope { where(
    channel_id: Channel.ids,
    created_at: Time.now - 3.months...Time.now,
    return?:    false,
    total:      (100..Float::INFINITY)
  )}

  belongs_to :channel, foreign_key: ENV['ORDERS_CUSTOMER_ID']

end
