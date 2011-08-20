$(function() {
    window.GameResult = Backbone.Model.extend({
        defaults: {
            name: ''
        },

        initialize: function(){
            _.bindAll(this, 
                'gameResultCreateSuccess',
                'gameResultCreateError',
                'savegameResultFacebookRequestId');
            $('form#new_result').bind('ajax:success', this.gameResultCreateSuccess);
            $('form#new_result').bind('ajax:error', this.gameResultCreateError);
        },
        gameResultCreateSuccess: function(e,response){
            console.log("Result created OK")
            this.set(response.model.result);
            $("<div></div>").html(response.message +
                "<br/><input type='checkbox' class='create_facebook_request'>Send Request via Facebook</input>")
            .dialog({
                buttons: {
                    Ok: function(){
                        if ($(this).find('input')[0].checked){
                            GameResultView.sendFacebookgameResultRequest(response.message);
                        }
                        $(this).dialog("close");
                    }
                }
            });
        },
        gameResultCreateError: function(e, response){
            var data = JSON.parse(response.responseText);
            if (response.status == 201){
                //actually everythoing went ok, some $ bug doesn't like my JSON
                try {
                    if (data.model){
                        this.gameResultCreateSuccess(e,data);
                        return;
                    }
                }
                catch(ex){
                    console.debug("Maybe actually something DID go wrong..." + ex);
                }
            }
            
            var error_messages=[];
            _(data).each( function(errors,attribute){
                error_messages.push("-"+attribute+" " + errors.join(", "));
            });
            $("<div></div>").html(error_messages.join("/n"))
            .dialog(
            {
                title: 'Errors saving the gameResult'
            }
            );

        },
        toggleSendFacebookRequest: function(){
            this.set({sendFacebookRequest: ! this.get("sendFacebookRequest")});
        },
        savegameResultFacebookRequestId: function(response){
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
                url: "/confirmations/" + this.get("gameResult_data").confirmations[0].code,
                type: 'PUT',
                data: {
                    'confirmation[facebook_request_id]': requestId
                },
                success: this.user_logged_in
            })
        }
        
    });

    window.GameResultView = Backbone.View.extend({
        el: "#new_result",
        
        initialize: function(){
            _.bindAll(this, 'render','sendFacebookgameResultRequest', 'toggleSendFacebookRequest');
            $('input.create_facebook_request').live('click', this.toggleSendFacebookRequest);
        },
        toggleSendFacebookRequest: function(e,value){
            this.model.toggleSendFacebookRequest();
        },
        render: function(){
            return this;
        },
        sendFacebookgameResultRequest: function(message){
            console.debug("FB:Request panel for Result:" +this.model.get('id'));
            var result = this.model.attributes;
            
            var destination_players = _([result.game.team1.players[1]]).chain()
                                       .union(result.game.team2.players)
                                       .uniq();

            FB.ui({
                method: 'apprequests',
                to: destination_players.pluck('facebook_id'),
                message: msg,
                data: 'tracking information for the user'
            },this.model.saveGameFacebookRequestId);
        }

    });
    window.GameResult = new GameResult();
    window.GameResultView = new GameResultView({
        model: window.GameResult
    });
})