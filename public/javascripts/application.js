$(function() {

    $('button.set_game_result_button').live('click', function(e){
       var result_panel= $(e.target.parentNode).next();
       result_panel.show();
    });

})