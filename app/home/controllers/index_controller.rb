class IndexController < ModelController
  model :page

  def initialize
    super
  end
  
  def dom_ready
    %x{
      $('.navbar-collapse a').click(function(){
        $('.navbar-collapse').toggleClass('in').toggleClass('collapse')
      });
      
      $('body').attr('data-spy', 'scroll');
      
      $('body').on('activate.bs.scrollspy', function () {
        $('.last-active').removeClass('last-active');
        $('.active').last().addClass('last-active');
      });
      
      $('.affix').affix({
        offset: {
          top: 240
        , bottom: 0
        }
      });
      
      $('body').scrollspy();
    }
    
    params._view.on('changed') do
      if true
        %x{
          $('.affix').affix({
            offset: {
              top: 240
            , bottom: 0
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
    self._contacts << page._new_contact.to_h.cur
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
  
  def nav_click(i)
    # %x{
    #   oldLoc = $('body').data('loc');
    #   $('body').data('loc', i);
    #   console.log(i, oldLoc)
    #   if(i > oldLoc){
    #     $('body').addClass('right')
    #   }else{
    #     $('body').removeClass('right')
    #   }
    # }
  end
  
  def escape(string)
    string.gsub(/[&\"<>]/, TABLE_FOR_ESCAPE_HTML__)
  end
  
  TABLE_FOR_ESCAPE_HTML__ = {
      "'" => '&#39;',
      '&' => '&amp;',
      '"' => '&quot;',
      '<' => '&lt;',
      '>' => '&gt;',
      '{' => '{"&#123;"}',
      '}' => '{38.chr + "#125;"}'
    }

end
