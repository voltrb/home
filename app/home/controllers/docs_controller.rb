class DocsController < ModelController
  model :page

  def initialize
    super

  end
  
  def dom_ready
    %x{
      prettyPrint();
      $('h1').attr('id', function(){
        return $(this).text().toLowerCase();
      });
    }
  end

end
