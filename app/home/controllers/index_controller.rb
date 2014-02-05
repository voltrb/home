class IndexController < ModelController
  model :page

  def initialize
    super
    
    
  end
  
  def dom_ready
    puts 'test'
    %x{
      var listen = $('.nav-link').click(function(){
        console.log('clicked')

      })
    }
    `$('body').data('loc', $('.nav-link.active').data('loc'))`
  end
  
  def dom_remove
    puts 'removed'
    `listen.remove();`
  end
  
  def nav_click(i)
    %x{
      return false;
      oldLoc = $('body').data('loc');
      $('body').data('loc', i);
      console.log(i, oldLoc)
      if(i > oldLoc){
        $('body').addClass('right')
      }else{
        $('body').removeClass('right')
      }
    }
  end

end
