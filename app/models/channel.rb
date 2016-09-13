class Channel < RemoteDB

  self.table_name  = ENV['CHANNELS_TABLE_NAME']
  self.primary_key = ENV['CHANNELS_PRIMARY_KEY']

  alias_attribute :id,    ENV['CHANNELS_PRIMARY_KEY']
  alias_attribute :name,  ENV['CHANNELS_NAME']

  default_scope { where(id: @selected_channel_ids) }

  @selected_channel_ids = ENV['SELECTED_CHANNEL_IDS'].split(',').map(&:to_i)

  has_many :orders,        foreign_key: ENV['ORDERS_CUSTOMER_ID']
  has_many :order_details, through: :orders
  has_many :products,      through: :order_details

  def nickname
    channels_names_dictionary = Hash[*(ENV['CHANNELS_NAMES_DICTIONARY'].split(','))]
    channels_names_dictionary[name]
  end

end
