# frozen_string_literal: true
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :omniauthable,
         :trackable, :validatable, omniauth_providers: [:facebook]

  ###=> associations

  has_one :order, -> { where state: :in_progress }

  has_many :orders
  has_many :reviews

  belongs_to :billing_address, class_name: Address
  belongs_to :shipping_address, class_name: Address

  ###=> form configurations

  accepts_nested_attributes_for :billing_address, :shipping_address

  ###=> delegates

  delegate :in_progress, :in_queue, :in_delivery, :delivered,
           :canceled, to: :orders, prefix: true

  ###=> scopes

  scope :facebook_user, -> (provider, uid) do
    where(provider: provider, uid: uid).first_or_initialize
  end

  ###=> methods

  %i(billing_address shipping_address).each do |field|
    define_method(field) do
      super() || send("build_#{field}", {
        firstname: self.firstname,
        lastname: self.lastname
      })
    end
  end

  def self.from_omniauth(auth)
    facebook_user(auth.provider, auth.uid).tap do |user|
      name, surname = auth.info.name.split /\s/
      user.firstname = name
      user.lastname = surname

      user.uid = auth.uid
      user.email = auth.info.email
      user.provider = auth.provider
      user.password = Devise.friendly_token[0, 20]
      user.save
    end
  end

  def self.new_with_session(_, session)
    super.tap do |user|
      data = session['devise.facebook_data']

      if data && session['devise.facebook_data']['extra']['raw_info']
        user.email = data['email'] if user.email.blank?
      end
    end
  end

  def mark_as_deleted
    update deleted_at: Time.zone.now
  end

  def active_for_authentication?
    super && !deleted_at
  end

  def inactive_message
    !deleted_at ? super : :deleted_account
  end

  def label
    "Email: #{email}"
  end
end
