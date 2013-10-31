class CollaboratorImporter
  ACCEPT_CONTENT_TYPE = 'text/plain'
  LINE_FORMAT = /\A\d{4}\s+\d{4}\s+\w.*\z/

  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_reader :file, :total_created, :total_updated
  validates_presence_of :file
  validate :require_uploaded_file
  validate :require_text_content_type

  def persisted?
    false
  end

  # Example file structure, remember we are always dealing with questor_id.
  # Comp / Collab / Name
  # 0001  0002  COLLABORATOR NAME
  def save
    valid? && process!
  end

  def warnings
    @warnings ||= ActiveModel::Errors.new(self)
  end

  private

  def initialize(attributes={})
    @file      = attributes[:file] if attributes
    @companies = {}
    @total_created = @total_updated = 0
  end

  def require_uploaded_file
    errors.add(:file, :invalid) unless file.respond_to?(:tempfile)
  end

  def require_text_content_type
    errors.add(:file, :invalid) unless file.respond_to?(:content_type) &&
                                       file.content_type == ACCEPT_CONTENT_TYPE
  end

  def process!
    Collaborator.transaction do
      # Force encoding to iso8859-1 to work with windows generated files and
      # accented chars.
      lines = @file.tempfile.read
      lines.force_encoding("iso8859-1") if lines.respond_to?(:force_encoding)
      lines.each_line do |line|
        if line.present? && line.chomp =~ LINE_FORMAT
          company_id, collaborator_id, *collaborator_name = line.split
          company      = find_company(company_id) or (add_company_not_found_warning(company_id) and return)
          collaborator = company.collaborators.find_or_initialize_by_questor_id(collaborator_id)

          if collaborator.persisted?
            @total_updated += 1
          else
            @total_created += 1
          end
          collaborator_name = collaborator_name.join(' ').encode('utf-8')

          collaborator.update_attributes(:name => collaborator_name)
        end
      end

      true
    end
  end

  def find_company(id)
    @companies[id] ||= Company.find_by_questor_id(id)
  end

  def add_company_not_found_warning(company_id)
    warnings.add(:base, :company_not_found, :company_id => company_id)
  end
end
