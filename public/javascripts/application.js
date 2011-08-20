$(function() {
    //mock firebug console if undefined
    if(typeof console === "undefined") {
       console = { log: function() { } };
    }
    $('button.set_game_result_button').live('click', function(e){
        var result_panel= $(e.target.parentNode).next();
        result_panel.toggleClass("inactive");
    });
    
    $('button.result_add_new_set_button').live('click', function(e){
        addNewResultRow();
    });

    function addNewResultRow(){
        var result_table= $('table.result_sets_table');
        var index = result_table.find("tr.result_set_row").length ;
        $("input.lastInput").removeClass("lastInput");
        var item=
        '<tr class="result_set_row">'+
        '<td><input class="result_set_team_score_input" type="text" name="result[result_sets]['+index+'][team1]"></input></td>'+
        '<td><input class="result_set_team_score_input, lastInput" type="text" name="result[result_sets]['+index+'][team2]"></input></td>'+
        '<td><button class="result_add_new_set_button" onclick="return false;">+</button></td>'+
        '</tr>'
        result_table.append(item);

    }


    $('input.lastInput).live('keypress', function(e){
        if (e.charCode == 0 && e.keyCode == 9 ) {
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
