# frozen_string_literal: true
module RailsAdmin
  module Config
    module Actions
      class BulkHide < RailsAdmin::Config::Actions::Base
        RailsAdmin::Config::Actions.register self

        register_instance_option(:bulkable?) { true }
        register_instance_option(:link_icon) { 'icon-eye-close' }

        register_instance_option :controller do
          proc do
            @objects = list_entries @model_config
            @objects.each { |object| object.update_attribute :visible, false; p object.class }
            flash[:success] = "#{@model_config.label} successfully hidden."
            redirect_to back_or_index
          end
        end
      end
    end
  end
end
