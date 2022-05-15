# frozen_string_literal: true

class User < ApplicationRecord
  authenticates_with_sorcery!
  has_many :authentications, :dependent => :destroy
  accepts_nested_attributes_for :authentications

  validates :password, length: { minimum: 6 },
    if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true,
    if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true,
    if: lambda {new_record? || changes[:crypted_password]}
  validates :email, uniqueness: true, presence: true
  validates :username, uniqueness: true, presence: true
  has_many :products
end
