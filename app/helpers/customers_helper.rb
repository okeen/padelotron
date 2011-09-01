module CustomersHelper
   def customer_top_navigation_menu
    content_tag :ul, :id => 'nav' do |ul|
      (
          "<li>#{link_to("Agenda", customers_agenda_path)}</li>"+
          "<li>#{link_to("Graficas", customers_graphic_path)}</li>"
      ).html_safe
    end
  end
end
