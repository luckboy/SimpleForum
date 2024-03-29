# RailsAdmin config file. Generated on December 31, 2011 01:41
# See github.com/sferik/rails_admin for more informations

RailsAdmin.config do |config|

  # If your default_local is different from :en, uncomment the following 2 lines and set your default locale here:
  # require 'i18n'
  # I18n.default_locale = :de

  config.current_user_method { current_user } # auto-generated

  # Set the admin name here (optional second array element will appear in a beautiful RailsAdmin red ©)
  config.main_app_name = ['Simple Forum', 'Admin']
  # or for a dynamic name:
  # config.main_app_name = Proc.new { |controller| [Rails.application.engine_name.titleize, controller.params['action'].titleize] }


  #  ==> Global show view settings
  # Display empty fields in show views
  # config.compact_show_view = false

  #  ==> Global list view settings
  # Number of default rows per-page:
  # config.default_items_per_page = 20

  #  ==> Included models
  # Add all excluded models here:
  # config.excluded_models = [Forum, Post, Topic, User]

  # Add models here if you want to go 'whitelist mode':
  #config.included_models = [Forum, Post, Topic, User]

  # Application wide tried label methods for models' instances
  # config.label_methods << :description # Default is [:name, :title]

  #  ==> Global models configuration
  # config.models do
  #   # Configuration here will affect all included models in all scopes, handle with care!
  #
  #   list do
  #     # Configuration here will affect all included models in list sections (same for show, export, edit, update, create)
  #
  #     fields_of_type :date do
  #       # Configuration here will affect all date fields, in the list section, for all included models. See README for a comprehensive type list.
  #     end
  #   end
  # end
  #
  #  ==> Model specific configuration
  # Keep in mind that *all* configuration blocks are optional.
  # RailsAdmin will try his best to provide the best defaults for each section, for each field.
  # Try to override as few things as possible, in the most generic way. Try to avoid setting labels for models and attributes, use ActiveRecord I18n API instead.
  # Less code is better code!
  # config.model MyModel do
  #   # Cross-section field configuration
  #   object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #   label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #   label_plural 'My models'      # Same, plural
  #   weight -1                     # Navigation priority. Bigger is higher.
  #   parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #   navigation_label              # Sets dropdown entry's name in navigation. Only for parents!
  #   # Section specific configuration:
  #   list do
  #     filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #     items_per_page 100    # Override default_items_per_page
  #     sort_by :id           # Sort column (default is primary key)
  #     sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     # Here goes the fields configuration for the list view
  #   end
  # end

  # Your model's configuration, to help you get started:

  # All fields marked as 'hidden' won't be shown anywhere in the rails_admin unless you mark them as visible. (visible(true))

  # config.model Forum do
  #   # Found associations:
  #     configure :topics, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :string 
  #     configure :description, :text 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Post do
  #   # Found associations:
  #     configure :author, :belongs_to_association 
  #     configure :topic, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :body, :text 
  #     configure :author_id, :integer         # Hidden 
  #     configure :topic_id, :integer         # Hidden 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Topic do
  #   # Found associations:
  #     configure :author, :belongs_to_association 
  #     configure :forum, :belongs_to_association 
  #     configure :posts, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :subject, :string 
  #     configure :author_id, :integer         # Hidden 
  #     configure :forum_id, :integer         # Hidden 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model User do
  #   # Found associations:
  #     configure :topics, :has_many_association 
  #     configure :posts, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :login, :string 
  #     configure :email, :string 
  #     configure :crypted_password, :string 
  #     configure :password_salt, :string 
  #     configure :persistence_token, :string 
  #     configure :single_access_token, :string 
  #     configure :perishable_token, :string 
  #     configure :login_count, :integer 
  #     configure :failed_login_count, :integer 
  #     configure :last_request_at, :datetime 
  #     configure :current_login_at, :datetime 
  #     configure :last_login_at, :datetime 
  #     configure :current_login_ip, :string 
  #     configure :last_login_ip, :string 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :real_name, :string 
  #     configure :website, :string 
  #     configure :location, :string 
  #     configure :is_admin, :boolean 
  #     configure :is_mod, :boolean   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
end

require "rails_admin/application_controller"

module RailsAdmin
  class ApplicationController < ::ApplicationController
    before_filter :can_admin?

    private
    def can_admin?
      raise CanCan::AccessDenied unless current_user && current_user.admin?
    end
  end
end
