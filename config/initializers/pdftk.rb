
##
# https://github.com/mileszs/wicked_pdf/issues/137
##

class Pdftk
  # take in an array of path objects
  # and return a tempfile of the resulting PDF
  def self.combine(files)
    if files.any?
      temp_file = Tempfile.new('adj_index')
      `pdftk #{files.join(' ')} cat output #{temp_file.path.to_s}`
      raise "Problem combining PDF files: #{files.join(' ')}" unless $?.success?
      temp_file
    end
  end
end
