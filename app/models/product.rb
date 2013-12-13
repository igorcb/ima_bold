class Product < ActiveRecord::Base
  belongs_to :category

  validates :name, presence: true, length: { maximum: 30 }
  #validates :active, presence: true
  validates :category_id, presence: true

  def ativo_inativo
  	case self.active 
  	  when true then "Ativo"
  	  when false then "Inativo"
  	end
  end
end
