class Image < ActiveRecord::Base
  belongs_to :category, :polymorphic => true
  belongs_to :product, :polymorphic => true
end
