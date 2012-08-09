class Pdfupload < ActiveRecord::Base
  has_attached_file :file
   has_many :controls

   validates_attachment_presence :file, :message => "field can\'t be empty"
   validates_attachment_content_type :file, :content_type => ['application/pdf']
   #validates_uniqueness_of :file, :file_name, :message => "File name already exists"
   
end
