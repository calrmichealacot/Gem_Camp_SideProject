class Item < ApplicationRecord
  enum status: { active: 0, inactive: 1 }

  has_many :item_category_ships
  has_many :categories, through: :item_category_ships

  scope :filter_by_category, -> (category_name) { includes(:categories).where(categories: { name: category_name } ) }

  default_scope { where(deleted_at: nil) }

  mount_uploader :image, ImageUploader

  def destroy
    update(deleted_at: Time.current)
  end

  include AASM
  has_many :bets

  aasm column: :state do
    state :pending, initial: true
    state :starting, :paused, :ended, :cancelled

    event :start do
      transitions from: [:pending, :cancelled, :ended], to: :starting, guard: :can_start?, success: :change_quantity_and_batch_count
      transitions from: :paused, to: :starting
    end

    event :pause do
      transitions from: :starting, to: :paused
    end

    event :end do
      transitions from: :starting, to: :ended, guard: :reached_min_bets?, success: :select_winner
    end

    event :cancel do
      transitions from: [:starting, :paused], to: :cancelled, success: :update_bets_state
    end
  end

  private

  def can_start?
    quantity > 0 && Time.current < offline_at && active?
  end

  def reached_min_bets?
    bets.betting.where(item: self, batch_count: batch_count).count >= minimum_bets
  end

  def change_quantity_and_batch_count
    update(quantity: quantity - 1, batch_count: batch_count + 1)
  end

  def update_bets_state
    bets.where(item: self, batch_count: batch_count).each { |bet| bet.cancel! if bet.may_cancel? }
    update(quantity: quantity + 1)
  end
end
