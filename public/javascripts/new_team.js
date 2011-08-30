$(function() {
    window.NewTeam = Backbone.Model.extend({
        defaults: {
            name: ''
        },

        initialize: function(){
            _.bindAll(this, 
                'teamCreateSuccess',
                
                'teamCreateError',
                'saveTeamFacebookRequestId');
            $('form#new_team').live('ajax:success', this.teamCreateSuccess);
            $('form#new_team').live('ajax:error', this.teamCreateError);
        },
        teamCreateSuccess: function(e,response){
            this.set({team_data: response.model});
            $("<div></div>").html(response.message +
                "<br/><input type='checkbox' class='create_facebook_request'>Send Request via Facebook</input>")
            .dialog({
                buttons: {
                    Ok: function(){
                        if ($(this).find('input')[0].checked){
                            newTeamView.sendFacebookTeamRequest(response.message);
                        }
                        $(this).dialog("close");
                    }
                }
            });
        },
        teamCreateError: function(e, response){
            var error_messages=[];
            var errors_obj = $.parseJSON(response.responseText);
            _(errors_obj).each( function(errors,attribute){
                error_messages.push("-"+attribute+" " + errors.join(", "));
            });
            $("<div></div>").html(error_messages.join("/n"))
            .dialog(
            {
                title: 'Errors saving the team'
            }
            );

        },
        toggleSendFacebookRequest: function(){
            this.set({sendFacebookRequest: ! this.get("sendFacebookRequest")});
        },
        saveTeamFacebookRequestId: function(response){
            if (!response) {
                console.log("FB:Request Error, did not receive request_ids");

            }
            console.log("FB:Request created, id:" + response);
            var requestId = response.request_ids[0];
            if (! requestId) {
                console.log("FB:Request response ERROR, no request id:" + response);
                return;
            }
            $.ajax({
                url: "/confirmations/" + this.get("team_data").confirmations[0].code,
                type: 'PUT',
                data: {
                    'confirmation[facebook_request_id]': requestId
                },
                success: this.user_logged_in
            })
        }
        
    });

    window.NewTeamView = Backbone.View.extend({
        el: "#new_team",
        
        initialize: function(){
            _.bindAll(this, 'render','sendFacebookTeamRequest', 'toggleSendFacebookRequest');
            $('input.create_facebook_request').live('click', this.toggleSendFacebookRequest);
             $('div.player_selector.second_player_selector').flexbox('/players.json', {
                watermark: "Select your team mate",
                onSelect: this.selectPlayerFromCombo,
                width: 300,
                resultTemplate: '<div class="player_result_row">'+
            '<div class="mini_player_info_row"><h5>{name}</h5></div>'+
            '<img class="player_mini_image" src=""></img></div>'
            });
        },
        selectPlayerFromCombo: function(valueInput,idInput){
            var playerInfoPanel = $(valueInput.parentNode.parentNode).
                                 find("div.player_info_mini_panel");
            $.when($.ajax('/players/' + idInput.value )).
                then(function(response){
                    var d=response.model;
                    playerInfoPanel.html(
            '<img class="team_mini_image" src="'+d.image_path+'"></img>'+
            '<div class="team_info_details_subpanel">'+
                '<h5>'+d.name+'</h5>'+
                '<ul class="team_players">'+
                    '<li class="team_players">'+d.player1.name+'</li>'+
                     '<li class="team_players">'+d.player2.name+'</li>'+
                '</ul>'+
            '</div>');

            });

        },
        toggleSendFacebookRequest: function(e,value){
            this.model.toggleSendFacebookRequest();
        },
        render: function(){
            return this;
        },
        sendFacebookTeamRequest: function(message){
            console.debug("FB:Request panel for Team:" +this.model.get('name'));
            var team = this.model.get("team_data")
            //_.bind('save_team_facebook_request_id', this);
            FB.ui({
                method: 'apprequests',
                to: team.player2.facebook_id,
                message: message,
                data: 'tracking information for the user'
            },this.model.saveTeamFacebookRequestId);
        }
    });
    window.newTeam = new NewTeam();
    window.newTeamView = new NewTeamView({
        model: window.newTeam
    });
})