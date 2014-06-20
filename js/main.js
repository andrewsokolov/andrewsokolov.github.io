var GOOGLE_FORM_URL = "https://docs.google.com/forms/d/1ALMyFSUVhwvHEtscS63-PemL68Nv5AeHSvyVCAOi3Ec/formResponse";
var GOOGLE_FORM_INPUT_NAME = "entry.598210959";

$(function(){

    $('#logo img').on('mouseenter', function(){
       $(this).addClass('rotate-image');
    }).on('mouseout', function(){
        $(this).removeClass('rotate-image');
    });

    var status = true;

    setInterval((function(){

        if (status){
              $(this).addClass('snake-animation');
        } else {
              $(this).removeClass('snake-animation');
        }

        status = !status;

        setTimeout(function(){
            $(this).removeClass('snake-animation');
        }.bind(this), 2000)

    }).bind($('.download-btn')), 5000);

    $('#newsletter-form').submit(function(e){

        e.preventDefault();

        var input = $(this).find('.email-input');

        if (!input.val()){
            return;
        }

        var func = function(input, form, thank_you){
            $(input).val('');
            $(form).addClass('hidden');
            $(thank_you).removeClass('hidden');
        }.bind(null, input, $(this), $('.thank-you-text'));

        var data = {};
            data[GOOGLE_FORM_INPUT_NAME] = input.val();

        $.ajax({
            url: GOOGLE_FORM_URL,
            data: data,
            type: "POST",
            dataType: "xml",
            statusCode: {
                0: func,
                200: func
            }
        });
    });

});