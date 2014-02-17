class DocsController < ModelController
  model :page

  def initialize
    super
    
  end
  
  def dom_ready
    %x{    
      prettyPrint();
      $('.col-md-9').find('h1, h2, h3').attr('id', function(){
        return $(this).text().toLowerCase().replace(/[\*\^\'\!]/g, '').split(' ').join('-');
      });
      
      $('table').addClass('table table-bordered table-condensed table-striped table-responsive');
      console.log('docs dom ready')
     
    }
  end
  
  def dom_removed
    
  end

end
