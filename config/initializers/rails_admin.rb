# frozen_string_literal: true

RailsAdmin.config do |config|
  config.main_app_name = 'The Bookstore'

  config.show_gravatar = false
  config.label_methods = [:label]
  config.browser_validations = false

  # == Devise ==
  config.authenticate_with { authenticate_admin! }
  config.current_user_method { current_admin_user }

  ## == Cancan ==
  config.authorize_with :cancan

  config.actions do
    index

    new { except %i(Address CreditCard Order OrderDetail OrderItem Review) }

    show
    edit
    delete { except %i(Address CreditCard OrderDetail) }
    export
    dashboard
    bulk_delete { except %i(Address CreditCard OrderDetail) }

    # custom actions

    bulk_hide { only %i(Book Review) }
  end

  config.excluded_models = %i(Authorisation Categorisation)

  config.model Address do
    %i(firstname lastname country city street zipcode phone).each do |field|
      field field
    end
  end

  config.model OrderDetail do
    exclude_fields :order
  end

  config.model DeliveryMethod do
    list { scopes [:all, :active] }
  end

  config.model User do
    field :email
    field :created_at
    field :admin

    edit { exclude_fields :created_at }
  end

  [Author, Category].each do |model|
    config.model model do
      configure(:visible_books) { hide }
      edit { configure(:books) { hide } }
    end
  end

  config.model Book do
    configure(:visible) { label 'Shown in store' }
    show { exclude_fields :order_items }
    list { scopes [:all, :visible, :hidden] }
    edit { exclude_fields :reviews, :visible, :order_items }
  end

  config.model Review do
    parent User
    edit { field :visible }
  end

  config.model OrderItem do
    edit { field :quantity }
  end

  config.model Order do
    list do
      scopes %i(in_progress in_queue in_delivery delivered canceled)

      configure :state do
        formatted_value do
          state = bindings[:object].state
          I18n.t "order_states.#{state}"
        end
      end
    end

    show do
      configure :state do
        formatted_value do
          state = bindings[:object].state
          I18n.t "order_states.#{state}"
        end
      end
    end

    edit do
      field :state, :enum do
        enum do
          order = bindings[:object]

          states = order.aasm.states(permitted: true)
                        .map(&:name).unshift order.state

          states.each_with_object({}) do |value, hash|
            hash[I18n.t "order_states.#{value}"] = value; hash
          end
        end
      end
    end
  end
end
