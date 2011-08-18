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
            this.set({game_data: response.model.game});
            $("<div></div>").html(response.message +
                "<br/><input type='checkbox' class='create_facebook_request'>Send Request via Facebook</input>")
            .dialog({
                buttons: {
                    Ok: function(){
                        if ($(this).find('input')[0].checked){
                            newGameView.sendFacebookGameRequest();
                        }
                        $(this).dialog("close");
                    }
                }
            });
        },
        gameCreateError: function(e, response){
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
        saveGameFacebookRequestId: function(response){
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
                url: "/confirmations/" + this.get("game_data").confirmations[0].code,
                type: 'PUT',
                data: {
                    'confirmation[facebook_request_id]': requestId
                },
                success: this.user_logged_in
            })
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
        sendFacebookGameRequest: function(){
            console.debug("FB:Request panel for Game:" +this.model.get('name'));
            var game = this.model.get("game_data")
            var msg = game.player1.name + "wants you to join the game " + game.name;
            //_.bind('save_game_facebook_request_id', this);
            FB.ui({
                method: 'apprequests',
                to: game.player2.facebook_id,
                message: msg,
                data: 'tracking information for the user'
            },this.model.saveGameFacebookRequestId);
        }
    });
    window.newGame = new NewGame();
    window.newGameView = new NewGameView({
        model: window.newGame
    });
})