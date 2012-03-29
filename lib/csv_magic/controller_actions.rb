module CSVMagic
  module ControllerActions
    
    def self.included(base)
      base.extend(ClassMethods)
      base.csv_magic_config
    end
    
    module ClassMethods
      def csv_magic_config( options = {} )
        defaults = {
          :action => :import,
          :mapping => {},
          :file_field => :file
        }
        options = defaults.merge(options)
        write_inheritable_attribute(:map_fields_options, options)
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

    def create_resource_items_from_csv(resource_class)
      @csv_import_errors = []
      reader = Reader.new(params)
      reader.each do |row|
        resource = resource_class.new(row)
        unless resource.save
          @csv_import_errors.push resource.errors
        end
      end
      reader.remove_file if @csv_import_errors.empty?
    end

    def resource_class
      @resource_name ||= self.class.name.gsub(/Controller|Admin/, '').gsub(/:{4}/, '::').singularize
      @resource_class ||= @resource_name.constantize
    end

    def render_csv_import_form
      render 'csv_magic/import'
    end

    def handle_csv_post_request
      # already mapped
      if params[:fields]
        create_resource_items_from_csv(resource_class)
        if @csv_import_errors.empty?
          flash[:notice] = 'Die Daten wurden erfolgreich importiert.'
          redirect_to :action => :index
        else
          flash[:warning] = "Beim Importieren sind Fehler aufgetreten!"
          render 'csv_magic/import_errors'
        end
      #no mapping yet
      else
        @mapper = Importer.new(params, self.class.read_inheritable_attribute(:map_fields_options))
        @raw_data = @mapper.raw_data
        render 'csv_magic/mapper'
      end
    rescue MissingFileContentsError
      flash[:warning] = 'Bitte eine CSV-Datei hochladen.'
      render_csv_import_form
    rescue ::CSV::MalformedCSVError => e
      flash[:warning] = "Fehlerhaft formatierte CSV-Datei: #{e.message}"
      render_csv_import_form
    rescue ::Errno::ENOENT
      flash[:warning] = 'Datei nicht mehr auf dem Server. Bitte erneut hochladen!'
      render_csv_import_form
    rescue Exception => e
      flash[:warning] = e.message
      logger.error(e.message)
      logger.error(e.backtrace.join("\n"))
      render_csv_import_form
    end

  end
end
