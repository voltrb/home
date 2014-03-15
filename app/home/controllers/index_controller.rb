class IndexController < ModelController
  model :page

  def dom_ready
    %x{
      console.log('dom ready')
      prettyPrint();
      
      $('.navbar-collapse a').click(function(){
        $('.navbar-collapse').toggleClass('in').toggleClass('collapse')
      });
      
      $('.affix').affix({
        offset: {
          top: 240
        }
      });
      
      $('body').scrollspy();
      
      $('body').on('activate.bs.scrollspy', function () {
        $('.last-active').removeClass('last-active');
        $('.active').last().addClass('last-active');
      });
      
      $('table').addClass('table table-bordered table-condensed table-responsive');
    }
    
    params._controller.on('changed') do
      if true
        %x{
          prettyPrint();
          $('.affix').affix({
            offset: {
              top: 240
            }
          });
          
          $('body').scrollspy('refresh')
        }
      end
    end
    
  end
  
  def dom_remove
    affix.remove();
  end
  
  def add_contact
    self._contacts << page._new_contact.cur
    page._new_contact = {}
  end
  
  def remove_contact(index)
    self._contacts.delete_at(index)
  end
  
  def set_index(index)
    params._index = index
    self._current_contact = _contacts[params._index.to_i]
  end
  
  def select(event)
    %x{
      $(event.js_event.target).parents('.row').find('.active').removeClass('active');
      $(event.js_event.target).parent().addClass('active');
      index = $(event.js_event.target).parent().index();
      $(event.js_event.target).parents('.row').find('pre > code').eq(index).addClass('active');
    }
  end
  
  def escape(string)
    string.gsub('<', '&lt;').gsub('>', '&gt;')
  end

end
