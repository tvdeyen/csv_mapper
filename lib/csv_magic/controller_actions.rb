require 'fastercsv'

module CsvMagic
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
      resource_name = self.class.name.gsub(/Controller/, '').singularize
      resource_class = resource_name.constantize
      if request.post?
        # already mapped
        if params[:fields]
          create_resource_items_from_csv(resource_class)
          if @csv_import_errors.empty?
            flash[:notice] = 'Die Daten wurden erfolgreich importiert.'
            redirect_to :action => :index
          else
            flash[:warning] = "Beim Importieren sind Fehler aufgetreten!"
            render 'controller_actions/import'
          end
        #no mapping yet
        else
          @mapper = CsvMagic::Importer.new(params, self.class.read_inheritable_attribute(:map_fields_options))
          @raw_data = @mapper.raw_data
          render 'controller_actions/mapper'
        end
      else
        render 'controller_actions/import'
      end
    rescue CsvMagic::InconsistentStateError
      flash[:warning] = 'unbekannter Fehler.'
    rescue CsvMagic::MissingFileContentsError
      flash[:warning] = 'Bitte eine CSV-Datei hochladen.'
      render 'controller_actions/import'
    rescue FasterCSV::MalformedCSVError => e
      flash[:warning] = 'Fehlerhaft formatierte CSV-Datei: ' + e
      render 'controller_actions/import'
    rescue Errno::ENOENT
      flash[:warning] = 'Datei nicht mehr auf dem Server. Bitte erneut hochladen!'
      render 'controller_actions/import'
    end

private
    def create_resource_items_from_csv(resource_class)
      @csv_import_errors = []
      reader = CsvMagic::Reader.new(params)
      reader.each do |row|
        resource = resource_class.new(row)
        unless resource.save
          @csv_import_errors.push resource.errors
        end
      end
      reader.remove_file if @csv_import_errors.empty?
    end
    
  end
end
