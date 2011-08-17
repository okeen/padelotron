$(function() {
    $('button.set_game_result_button').live('click', function(e){
        var result_panel= $(e.target.parentNode).next();
        result_panel.toggleClass("inactive");
    });
    
    $('button.result_add_new_set_button').live('click', function(e){
        addNewResultRow();
    });


    $('form#new_team').live('ajax:success', function(e, response){

        $("<div></div>").html(response.message +
                         "<br/><input type='checkbox' name='create_facebook_request'>Send Request via Facebook</input>")
                        .dialog({
                            buttons: {Ok: function(){
                                    if ($(this).find('input')[0].checked){
                                        sendFacebookTeamRequest(response.model.team);
                                    }
                                    $(this).dialog("close");
                                }
                            }
                        });
    });

    $('form#new_team').live('ajax:error', function(e, response){
        var error_messages=[];
        var errors_obj = $.parseJSON(response.responseText);
        _(errors_obj).each( function(errors,attribute){
            error_messages.push("-"+attribute+" " + errors.join(", "));
        });
        $("<div></div>").html(error_messages.join("/n"))
                        .dialog(
                            {title: 'Errors saving the team'}
                    );
    });

//    window.fbAsyncInit = function() {
//        FB.init({
//            appId: window._facebook_appId,
//            status: true,
//            cookie: true,
//            xfbml: true
//        });
//
//
//    };

    
    function sendFacebookTeamRequest(team){
        console.debug("FB:Request panel for Team:" +team.name);
        var msg = team.player1.name + "wants you to join the team " + team.name;
        FB.ui({
            method: 'apprequests',
            to: team.player2.facebook_id,
            message: msg,
            data: 'tracking information for the user'
          },
         function(response){
            console.log("FB:Request created, id:" + response);
         });
    }
    
    function addNewResultRow(){
        var result_table= $('table.result_sets_table');
        var index = result_table.find("tr.result_set_row").length 
        var item=
        '<tr class="result_set_row">'+
        '<td><input class="result_set_team_score_input" type="text" name="result[result_sets]['+index+'][team1]"></input></td>'+
        '<td><input class="result_set_team_score_input" type="text" name="result[result_sets]['+index+'][team2]"></input></td>'+
        '<td><button class="result_add_new_set_button" onclick="return false;">+</button></td>'+
        '</tr>'
        result_table.append(item);

    }

    function isSecondScoreBox(scoreBox){
        var scoreSetRow = $(scoreBox).parent().parent();
        return $(scoreSetRow.children()[1]).children()[0] == scoreBox;
    }
    $('input.result_set_team_score_input').live('keypress', function(e){
        if (e.charCode == 0 && e.keyCode == 9 && isSecondScoreBox(e.target)) {
            addNewResultRow();
            return;
        }
        var set_values = $(e.target).parent().parent().parent()
        .find("tr.result_set_row").map(function(row_index){
            return $(this).find("input.result_set_team_score_input")
            .map(function(){
                var value = this.value;
                if (this == e.target)
                    value+= String.fromCharCode(e.charCode);
                return parseInt(value);
            }).get();
        }).get();
        //si es par
        if (set_values.length % 2 == 0)
            showProvisionalResult(set_values);
    });

    function showProvisionalResult(scoresList){
        var score = {
            team1: 0,
            team2: 0
        };

        for (var i=0; i<scoresList.length / 2; i++) {
            if (scoresList[i*2] == 6 && scoresList[i*2+1] < 6)
                score.team1 ++;
            if (scoresList[i*2] < 6 && scoresList[i*2+1] == 6)
                score.team2 ++;
        }
        showResult(score);
    }

    function showResult(score){
        $('h3.provisional_score').html("Score: " + score.team1 + ":" + score.team2);
    }

});
