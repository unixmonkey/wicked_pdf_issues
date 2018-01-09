WickedPdf.config = {
  #:wkhtmltopdf => '/usr/local/bin/wkhtmltopdf',
  #:layout => "pdf.html",
  # exe_path: '/usr/local/bin/wkhtmltopdf'
}

config_709 = {
  page_size: "Letter",
  margin:  {  bottom:            0,
              top:               0,
              left:              0,
              right:             0 }
}
Rails.application.config.middleware.use WickedPdf::Middleware, config_709, only: '/pages/issue_709'
