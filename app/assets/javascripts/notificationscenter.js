$(document).ready(function()
{
    $("#open_notification").click(function()
    {
        $("#notificationContainer").fadeToggle(300);
        $("#notification_count").fadeOut("fast");
        return false;
    });

    $(document).click(function()
    {
        $("#notificationContainer").hide();
    });


    $("#notificationContainer").click(function()
    {
        return false;
    });

    (function() {
      App.notifications = App.cable.subscriptions.create({
        channel: 'NotificationsChannel'
      },
      {
        connected: function() {},
        disconnected: function() {},
        received: function(data) {

          $('.notifications-wrapper').prepend('' + data.notification);
          $('.notification-item p').click(function(){
            window.location.href = $(this).find('a').first().attr('href');
          });

          return this.update_counter(data.counter);
        },
        update_counter: function(counter) {
          var $counter, val;
          $counter = $('#notification-counter');
          val = parseInt($counter.text());
          val++;
          return $counter.css({
          }).text(val)
            .css({
              top: '-10px'
            })
        }
      });
  }).call(this);
});
