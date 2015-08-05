module Main
  class MainController < Volt::ModelController
    model :page

    def index
      #page._items.clear
      #page._items << {_name: 'Take out trash'}
      #page._items << {_name: 'Make bed'}
      #page._items << {_name: 'Do dishes'}

      new_subscribe

      # store._items.find({}).then do |result|
      #   if result.size == 0
      #     store._items << {_text: 'New'}
      #   end
      # end
    end

    def new_subscribe
      page._subscribe = store._subscribers.buffer
    end

    def getting_started_ready
      dom_ready
    end

    def dom_ready
      puts 'dom ready'
      %x{
        prettyPrint();

        $('.col-md-9').find('h1, h2, h3').attr('id', function(){
          return $(this).text().toLowerCase().replace(/[\*\^\'\!]/g, '').split(' ').join('-');
        });

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

      # change = params._controller.on('changed') do
      #   if true
      #     %x{
      #       console.log('changed')
      #       prettyPrint();
      #
      #       $('.navbar-collapse a').click(function(){
      #         $('.navbar-collapse').toggleClass('in').toggleClass('collapse')
      #       });
      #
      #       $('.affix').affix({
      #         offset: {
      #           top: 240
      #         }
      #       });
      #
      #       $('body').scrollspy('refresh')
      #     }
      #   end
      # end

    end

    def dom_remove
      change.remove();
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

    def add_to_list
      page._subscribe.save! do
        flash._notices << "Subscribed to list"
        new_subscribe
      end
    end

    def components
      RubyGemsTask.search_components
    end

    private
      # the main template contains a #template binding that shows another
      # template.  This is the path to that template.  It may change based
      # on the params._controller and params._action values.
      def main_path
        "#{params._component || 'main'}/#{params._controller || 'main'}/#{params._action || 'index'}"
      end

  end
end
