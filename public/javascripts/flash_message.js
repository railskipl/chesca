var x;
x = $(document);
x.ready(show_message);
function show_message()
{
  var z;
  z = $(".form_product_button_1");
  z.live("click", function(){
    var message = $(".flash");
    message.show();
  });
};

