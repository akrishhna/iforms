class Control < ActiveRecord::Base
  belongs_to :pdfupload
  
  def self.paging(page, id)
        paginate :per_page => 25, :page => page,
                :conditions => ['pdfupload_id  = ?', id]
  end
end
