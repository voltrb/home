module Main
  class DocsController < Volt::ModelController

    def index_ready
      dom_ready
    end

    # TODO: Currently in 0.6 of opal, we've got an issue using a shared controller
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
    end
  end
end