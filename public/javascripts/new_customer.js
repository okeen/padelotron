$(function() {
    window.Customer = Backbone.Model.extend({
        defaults: {
            name: ''
        },
        initialize: function(){
            _.bindAll(this,
                'customerCreateSuccess',
                'customerCreateError');
            $('form#new_customer').bind('ajax:success', this.customerCreateSuccess);
            $('form#new_customer').bind('ajax:error', this.customerCreateError);
        },
        customerCreateSuccess: function(e,response){
            console.debug("Customer created ok:" + response.model.email);
            $('div#message_box_panel').html(response.message)
            .dialog({
                buttons: {
                    Ok: function(){
                        window.location.href= window.location.protocol + "//" +
                        window.location.host + "/";
                    }
                }
            });

        },
        customerCreateError: function(event, response){
            if (response.status == 201){
                //actually everythoing went ok, some $ bug doesn't like my JSON
                try {
                    var data = JSON.parse(response.responseText);
                    if (data.model){
                        this.customerCreateSuccess(event,data);
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
                console.debug("Customer save error:" + attribute + ": " + errors.join(", "));
            });
            $("<div></div>").html(error_messages.join("/n"))
            .dialog(
            {
                title: 'Errors saving the customer'
            }
            );
        }
    });
    
    window.CustomerView = Backbone.View.extend({
        el: "form#new_customer",
        customers: [],
        
        initialize: function(){
            _.bindAll(this, 'render');
            this.render();
        },
        render: function(){
            $("form#new_customer").formwizard({
                focusFirstInput : true,
                next: "input.navigation_button#next",
                formOptions :{
                }
            })

        }
    });
    window.customer = new Customer();
    window.customerView = new CustomerView({
        model: window.customer
    });
})