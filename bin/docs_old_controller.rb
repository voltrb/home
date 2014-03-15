class DocsController < ModelController
  model :page

  def initialize
    super
    puts 'docss'
  end
  
  def dom_ready
    %x{    

      $('.col-md-9').find('h1, h2, h3').attr('id', function(){
        return $(this).text().toLowerCase().replace(/[\*\^\'\!]/g, '').split(' ').join('-');
      });
      
      
     
    }
  end
  
  def dom_removed
    
  end

end
