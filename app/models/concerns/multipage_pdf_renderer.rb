# Usage:
# doc1 = render_to_string(template: 'pages/_page1')
# doc2 = render_to_string(template: 'pages/_page2')
# pdf_file = MultipagePdfRenderer.combine([doc1, doc2])
# send_data pdf_file, type: 'application/pdf', disposition: 'inline'

require 'open3'

class MultipagePdfRenderer
  def self.combine(documents)
    outfile = WickedPdfTempfile.new('multipage_pdf_renderer.pdf')

    tempfiles = documents.each_with_index.map do |doc, index|
      file = WickedPdfTempfile.new("multipage_pdf_doc_#{index}.html")
      file.binmode
      file.write(doc)
      file.rewind
      file
    end

    filepaths = tempfiles.map{ |tf| tf.path.to_s }

    binary = WickedPdf.new.send(:find_wkhtmltopdf_binary_path)

    command = [binary, '-q']
    filepaths.each { |fp| command << fp }
    command << outfile.path.to_s
    err = Open3.popen3(*command) do |stdin, stdout, stderr|
      stderr.read
    end

    raise "Problem generating multipage pdf: #{err}" if err.present?
    return outfile.read
  ensure
    tempfiles.each(&:close!)
  end
end
