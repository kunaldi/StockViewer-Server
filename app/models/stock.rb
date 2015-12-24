class Stock
  include Mongoid::Document

  field :symb, type: String
  field :name, type: String
  field :sector, type: String
  field :industry, type: String

  index({symb: 1}, background: true)


end