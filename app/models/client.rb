class Client < ApplicationRecord
  validates :name, :cpf_number, presence: true
  validates :cpf_number, uniqueness: true
  validates :cpf_number, length: { is: 11 }
  validates :cash, numericality: { greater_than_or_equal_to: 0.0 }

  enum status: { closed_account: 0, active: 1 }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
