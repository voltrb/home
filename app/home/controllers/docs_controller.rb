class DocsController < ModelController
  model :page

  def initialize
    super
    
  end
  
  def dom_ready
    %x{    
      prettyPrint();
      $('h1, h2, h3').attr('id', function(){
        return $(this).text().toLowerCase().replace(/[\*\^\'\!]/g, '').split(' ').join('-');
      });
      
      $('h1, h2, h3').attr('name', function(){
        return $(this).text().toLowerCase().replace(/[\*\^\'\!]/g, '').split(' ').join('-');
      });
      
      $('body').scrollspy({ target: '#spy-list' });
    }
  end

end
