class PagesController < ApplicationController

  def issue_339
    doc1 = render_to_string(template: 'pages/_page1')
    doc2 = render_to_string(template: 'pages/_page2')
    pdf_file = MultipagePdfRenderer.combine([doc1, doc2])
    send_data pdf_file, type: 'application/pdf', disposition: 'inline'
  end

  def issue_326
    @remember_token = CGI.escape(cookies['remember_token'].to_s)
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: 'issue_326',
          cookie: "_session_id #{@remember_token}"
      end
    end
  end

  def issue_321
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: 'issue_321',
          # cover: 'http://google.com',
          margin: { top: 40, bottom: 40 },
          toc: {
            header_text: 'THIS IS THE WAY THE WORLD ENDS',
            disable_dotted_lines: true,
            disable_toc_links: true,
            level_indentation: 10,
            text_size_shrink: 0.5
          }
      end
    end
  end

  def issue_327
    respond_to do |format|
      format.html do
        render layout: 'issue_327'
      end
      format.pdf do
        render pdf: 'oferta',
          layout: 'issue_327.html.erb',
          print_media_type: true,
          show_as_html: params[:debug]
      end
    end
  end

  def issue_330
    respond_to do |format|
      format.html
      format.pdf do
        if params[:show] == 'native'
          render pdf: 'issue_327',
            orientation: 'Landscape',
            page_width: 2000,
            dpi: 300
        elsif params[:show] == 'issue'
          pdf = WickedPdf.new.pdf_from_string(
            render_to_string(
              template: 'pages/issue_330',
              formats: [:pdf],
              handlers: [:erb],
              orientation: 'Landscape',
              page_width: '2000',
              dpi: '300'
            )
          )
          send_data pdf, type: 'application/pdf', disposition: 'inline'
        else
          string = render_to_string(
            template: 'pages/issue_330',
            formats: [:pdf],
            handlers: [:erb]
          )
          options = {
            orientation: 'Landscape',
            page_width: '2000',
            dpi: '300'
          }
          pdf = WickedPdf.new.pdf_from_string(string, options)
          send_data pdf, type: 'application/pdf', disposition: 'inline'
        end

      end
    end
  end

  def issue_370
    respond_to do |format|
      format.html do
        @html = true
        render :issue_370_with_svg_object
      end
      format.pdf do
        #rendering template with Base64 encoded SVG image, instead
        render pdf: 'issue'
      end
    end
  end

end
