# frozen_string_literal: true
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_160_819_140_843) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'addresses', force: :cascade do |t|
    t.string   'street',     null: false
    t.string   'firstname',  null: false
    t.string   'lastname',   null: false
    t.string   'city',       null: false
    t.string   'country',    null: false
    t.string   'phone',      null: false
    t.string   'zipcode',    null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['city'], name: 'index_addresses_on_city', using: :btree
    t.index ['country'], name: 'index_addresses_on_country', using: :btree
  end

  create_table 'authorisations', force: :cascade do |t|
    t.integer 'book_id',   null: false
    t.integer 'author_id', null: false
    t.index %w(author_id book_id), name: 'index_authorisations_on_author_id_and_book_id', unique: true, using: :btree
    t.index ['author_id'], name: 'index_authorisations_on_author_id', using: :btree
    t.index %w(book_id author_id), name: 'index_authorisations_on_book_id_and_author_id', unique: true, using: :btree
    t.index ['book_id'], name: 'index_authorisations_on_book_id', using: :btree
  end

  create_table 'authors', force: :cascade do |t|
    t.string   'firstname',                                null: false
    t.string   'lastname',                                 null: false
    t.text     'description', default: '(No description)', null: false
    t.datetime 'created_at',                               null: false
    t.datetime 'updated_at',                               null: false
    t.index ['firstname'], name: 'index_authors_on_firstname', using: :btree
    t.index ['lastname'], name: 'index_authors_on_lastname', using: :btree
  end

  create_table 'books', force: :cascade do |t|
    t.string   'title',                                                                   null: false
    t.boolean  'visible',                                    default: true,               null: false
    t.text     'description_short',                          default: '(No description)', null: false
    t.text     'description_full',                           default: '(No description)', null: false
    t.decimal  'price', precision: 10, scale: 2, null: false
    t.integer  'count', null: false
    t.string   'cover'
    t.datetime 'created_at',                                                              null: false
    t.datetime 'updated_at',                                                              null: false
    t.index ['title'], name: 'index_books_on_title', using: :btree
    t.index ['visible'], name: 'index_books_on_visible', where: 'visible', using: :btree
  end

  create_table 'categories', force: :cascade do |t|
    t.string   'name',       null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['name'], name: 'index_categories_on_name', unique: true, using: :btree
  end

  create_table 'categorisations', force: :cascade do |t|
    t.integer 'book_id',     null: false
    t.integer 'category_id', null: false
    t.index %w(book_id category_id), name: 'index_categorisations_on_book_id_and_category_id', unique: true, using: :btree
    t.index ['book_id'], name: 'index_categorisations_on_book_id', using: :btree
    t.index %w(category_id book_id), name: 'index_categorisations_on_category_id_and_book_id', unique: true, using: :btree
    t.index ['category_id'], name: 'index_categorisations_on_category_id', using: :btree
  end

  create_table 'coupons', force: :cascade do |t|
    t.string   'name',                      null: false
    t.integer  'discount',                  null: false
    t.boolean  'available', default: true, null: false
    t.datetime 'created_at',                null: false
    t.datetime 'updated_at',                null: false
    t.index ['name'], name: 'index_coupons_on_name', using: :btree
  end

  create_table 'credit_cards', force: :cascade do |t|
    t.string   'firstname',  null: false
    t.string   'lastname',   null: false
    t.string   'number',     null: false
    t.string   'code',       null: false
    t.string   'month',      null: false
    t.string   'year',       null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['firstname'], name: 'index_credit_cards_on_firstname', using: :btree
    t.index ['lastname'], name: 'index_credit_cards_on_lastname', using: :btree
    t.index ['number'], name: 'index_credit_cards_on_number', using: :btree
  end

  create_table 'delivery_methods', force: :cascade do |t|
    t.string   'name',                                                null: false
    t.boolean  'active',                              default: true,  null: false
    t.boolean  'default',                             default: false, null: false
    t.decimal  'price', precision: 10, scale: 2, null: false
    t.datetime 'created_at',                                          null: false
    t.datetime 'updated_at',                                          null: false
  end

  create_table 'order_details', force: :cascade do |t|
    t.integer  'credit_card_id'
    t.integer  'delivery_method_id'
    t.integer  'billing_address_id'
    t.integer  'shipping_address_id'
    t.string   'step', default: 'address', null: false
    t.datetime 'created_at',                              null: false
    t.datetime 'updated_at',                              null: false
    t.index ['billing_address_id'], name: 'index_order_details_on_billing_address_id', using: :btree
    t.index ['credit_card_id'], name: 'index_order_details_on_credit_card_id', using: :btree
    t.index ['delivery_method_id'], name: 'index_order_details_on_delivery_method_id', using: :btree
    t.index ['shipping_address_id'], name: 'index_order_details_on_shipping_address_id', using: :btree
    t.index ['step'], name: 'index_order_details_on_step', using: :btree
  end

  create_table 'order_items', force: :cascade do |t|
    t.integer  'quantity', default: 1, null: false
    t.decimal  'price',      precision: 10, scale: 2,             null: false
    t.decimal  'total',      precision: 10, scale: 2,             null: false
    t.integer  'book_id',                                         null: false
    t.integer  'order_id',                                        null: false
    t.datetime 'created_at',                                      null: false
    t.datetime 'updated_at',                                      null: false
    t.index ['book_id'], name: 'index_order_items_on_book_id', using: :btree
    t.index ['order_id'], name: 'index_order_items_on_order_id', using: :btree
  end

  create_table 'orders', force: :cascade do |t|
    t.decimal  'total_price',  precision: 10, scale: 2,                         null: false
    t.decimal  'items_price',  precision: 10, scale: 2,                         null: false
    t.string   'state', default: 'in_progress', null: false
    t.datetime 'completed_at'
    t.integer  'user_id'
    t.integer  'coupon_id'
    t.integer  'details_id'
    t.datetime 'created_at',                                                    null: false
    t.datetime 'updated_at',                                                    null: false
    t.index ['coupon_id'], name: 'index_orders_on_coupon_id', using: :btree
    t.index ['details_id'], name: 'index_orders_on_details_id', using: :btree
    t.index ['user_id'], name: 'index_orders_on_user_id', using: :btree
  end

  create_table 'reviews', force: :cascade do |t|
    t.string   'text',                       null: false
    t.integer  'mark',                       null: false
    t.boolean  'visible',    default: false, null: false
    t.boolean  'new',        default: true,  null: false
    t.datetime 'created_at',                 null: false
    t.datetime 'updated_at',                 null: false
    t.integer  'book_id',                    null: false
    t.integer  'user_id',                    null: false
    t.index ['book_id'], name: 'index_reviews_on_book_id', using: :btree
    t.index ['user_id'], name: 'index_reviews_on_user_id', using: :btree
  end

  create_table 'users', force: :cascade do |t|
    t.string   'email',                  default: '',    null: false
    t.string   'encrypted_password',     default: '',    null: false
    t.string   'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.integer  'sign_in_count', default: 0, null: false
    t.datetime 'current_sign_in_at'
    t.datetime 'last_sign_in_at'
    t.inet     'current_sign_in_ip'
    t.inet     'last_sign_in_ip'
    t.datetime 'created_at',                             null: false
    t.datetime 'updated_at',                             null: false
    t.boolean  'admin', default: false
    t.integer  'billing_address_id'
    t.integer  'shipping_address_id'
    t.datetime 'deleted_at'
    t.string   'uid'
    t.string   'provider'
    t.index ['billing_address_id'], name: 'index_users_on_billing_address_id', using: :btree
    t.index ['email'], name: 'index_users_on_email', unique: true, using: :btree
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true, using: :btree
    t.index ['shipping_address_id'], name: 'index_users_on_shipping_address_id', using: :btree
  end

  add_foreign_key 'authorisations', 'authors'
  add_foreign_key 'authorisations', 'books'
  add_foreign_key 'categorisations', 'books'
  add_foreign_key 'categorisations', 'categories'
  add_foreign_key 'order_details', 'addresses', column: 'billing_address_id'
  add_foreign_key 'order_details', 'addresses', column: 'shipping_address_id'
  add_foreign_key 'order_details', 'credit_cards'
  add_foreign_key 'order_details', 'delivery_methods'
  add_foreign_key 'order_items', 'books'
  add_foreign_key 'order_items', 'orders'
  add_foreign_key 'orders', 'coupons'
  add_foreign_key 'orders', 'order_details', column: 'details_id'
  add_foreign_key 'orders', 'users'
  add_foreign_key 'reviews', 'books'
  add_foreign_key 'reviews', 'users'
  add_foreign_key 'users', 'addresses', column: 'billing_address_id'
  add_foreign_key 'users', 'addresses', column: 'shipping_address_id'
end
