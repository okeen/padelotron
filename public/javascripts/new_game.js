$(function() {
    window.NewGame = Backbone.Model.extend({
        defaults: {
            name: ''
        },

        initialize: function(){
            _.bindAll(this, 
                'gameCreateSuccess',
                
                'gameCreateError',
                'saveGameFacebookRequestId');
            $('form#new_game').live('ajax:success', this.gameCreateSuccess);
            $('form#new_game').live('ajax:error', this.gameCreateError);
        },
        gameCreateSuccess: function(e,response){
            this.set(response.model.game);
            $("<div></div>").html(response.message +
                "<br/><input type='checkbox' class='create_facebook_request'>Send Request via Facebook</input>")
            .dialog({
                buttons: {
                    Ok: function(){
                        if ($(this).find('input')[0].checked){
                            newGameView.sendFacebookGameRequest(response.message);
                        }
                        $(this).dialog("close");
                    }
                }
            });
        },
        gameCreateError: function(e, response){
            if (response.status == 201){
                //actually everythoing went ok, some $ bug doesn't like my JSON
                try {
                    var data = JSON.parse(response.responseText);
                    if (data.model){
                        this.gameCreateSuccess(e,data);
                        return;
                    }
                }
                catch(ex){
                    console.debug("Maybe actually something DID go wrong..." + ex);
                }
            }
            var error_messages=[];
            var errors_obj = $.parseJSON(response.responseText);
            _(errors_obj).each( function(errors,attribute){
                error_messages.push("-"+attribute+" " + errors.join(", "));
            });
            $("<div></div>").html(error_messages.join("/n"))
            .dialog(
            {
                title: 'Errors saving the game'
            }
            );

        },
        toggleSendFacebookRequest: function(){
            this.set({sendFacebookRequest: ! this.get("sendFacebookRequest")});
        },
        saveGameFacebookRequestId: function(requestIds){
            if (!requestIds) {
                console.log("FB:Request Error, did not receive request_ids");

            }
            console.log("FB:Request created, id:" + requestIds);
            if (requestIds.length == 0) {
                console.log("FB:Request response ERROR, no request id:" + requestIds);
                return;
            }
//            $.ajax({
//                url: "/confirmations/" + this.get("game_data").confirmations[0].code,
//                type: 'PUT',
//                data: {
//                    'confirmation[facebook_request_id]': requestIds
//                },
//                success: this.user_logged_in
//            });
        }
        
    });

    window.NewGameView = Backbone.View.extend({
        el: "#new_game",
        
        initialize: function(){
            _.bindAll(this, 'render','sendFacebookGameRequest', 'toggleSendFacebookRequest');
            $('input.create_facebook_request').live('click', this.toggleSendFacebookRequest);
        },
        toggleSendFacebookRequest: function(e,value){
            this.model.toggleSendFacebookRequest();
        },
        render: function(){
            return this;
        },
        sendFacebookGameRequest: function(message){
            console.debug("FB:Request panel for Game:" +this.model.get('id'));
            var game = {
                    description: this.model.get("description"),
                    team1: this.model.get("team1"),
                    team2: this.model.get("team2"),
                    play_date: this.model.get("play_date")
            }
            var destination_players = _([game.team1.players[1]]).chain()
                                       .union(game.team2.players)
                                       .uniq();
                                        
            FB.ui({
                method: 'apprequests',
                to: destination_players.pluck('facebook_id'),
                message: message,
                data: 'tracking information for the user'
            },this.model.saveGameFacebookRequestId);
        }

    });
    window.newGame = new NewGame();
    window.newGameView = new NewGameView({
        model: window.newGame
    });
})