module CSVMapper
  module ControllerActions
    def self.included(base)
      base.send(:class_attribute, :map_fields_options)
      base.extend(ClassMethods)
      base.csv_mapper_config
      base.send(:helper_method, :resource_url_proxy)
    end

    module ClassMethods
      def csv_mapper_config(options = {})
        defaults = {
          :action => :import,
          :mapping => {},
          :file_field => :file,
        }
        options = defaults.merge(options)
        self.map_fields_options = options
      end
    end

    def import
      if request.post?
        handle_csv_post_request
      else
        render_csv_import_form
      end
    end

    private

    # Creates resources from CSV data.
    #
    # Overwrite this in your controller, if you need to do something else
    # (updating existing records, for instance).
    #
    def create_resource_items_from_csv
      @csv_import_errors = []
      reader = CSVMapper::Reader.new(params)
      reader.each do |row|
        resource = resource_class.new(row)
        unless resource.save
          @csv_import_errors.push resource.errors
        end
      end
      reader.remove_file if @csv_import_errors.empty?
    end

    # Tries to guess the resource class name (the model) from our controller name.
    # Overwrite this in your controller, if this doesn't work correctly.
    def resource_class
      @resource_name ||= self.class.name.gsub(/Controller|Admin/, "").gsub(/:{4}/, "::").singularize
      @resource_class ||= @resource_name.constantize
    end

    # Overwrite this method in your controller, if you use this inside a gem engine.
    def resource_url_proxy
      main_app
    end

    def render_csv_import_form
      if @_lookup_context.exists?("#{controller_path}/import")
        render "import"
      else
        render "csv_mapper/import"
      end
    end

    # Overwrite this, if you want to redirect to a different url
    def csv_mapper_redirect_url
      resource_url_proxy.url_for(action: "index")
    end

    def handle_csv_post_request
      try_create_from_csv || render_mapper
    end

    def try_create_from_csv
      return if params[:fields].blank?
      create_resource_items_from_csv
      if @csv_import_errors.empty?
        flash[:notice] = t(:successfully_imported_data, scope: :csv_mapper)
        redirect_to csv_mapper_redirect_url
      else
        flash[:warning] = t(:errors_while_importing, scope: :csv_mapper)
        render "csv_mapper/import_errors"
      end
    rescue MissingFileContentsError
      flash[:error] = t(:please_upload_a_csv_file, scope: :csv_mapper)
      render_csv_import_form
    rescue ::CSV::MalformedCSVError => e
      flash[:error] = t(:csv_file_has_wrong_format, scope: :csv_mapper, error: e.message)
      render_csv_import_form
    rescue ::Errno::ENOENT
      flash[:error] = t(:file_not_on_server_any_more, scope: :csv_mapper)
      render_csv_import_form
    rescue Exception => e
      # Protection from CookieOverflow errors, if large sql queries fail
      flash[:error] = "#{e.message[0..100]}..."
      Rails.logger.error(e.message)
      Rails.logger.error(e.backtrace.join("\n"))
      render_csv_import_form
    end

    def render_mapper
      @mapper = CSVMapper::Importer.new(params, self.class.map_fields_options)
      if @_lookup_context.exists?("#{controller_path}/mapper")
        render "mapper"
      else
        render "csv_mapper/mapper"
      end
    end
  end
end
