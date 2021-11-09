/* Initialisation */

$('#ppFeedback').hide();
$('#ppFeedback').delay(500).slideDown();

// Au clic sur le bouton
$('#feedback').click(function(){
	$('#ppFeedback').removeClass('dN');
	$('#ppFeedback').slideToggle();
});


// A l'envoi du texte
$("#txtFeedBack").submit(function(e){
	if($('#txtFeedBack textarea').val() != ''){
		$('#txtFeedBack').remove();
		if(!$('#note').length)
      $('#ppFeedback').remove();
	}
    return false;
});

// Au clic sur une note
$('#listeNote li').click(function(){
	$(this).find('span').css({
    'background-color' : 'orange',
    'box-shadow' : '0 0 5px -1px #141414'});
	$('#note').slideUp("normal", function() {
    $(this).remove();
  });
	if(!$('#txtFeedBack').length)
    $('#ppFeedback').remove();
})


// Au clic sur le bouton "ne plus afficher"
$('#closePpFb').click(function(){
	$('#ppFeedback').removeClass('dN');
	$('#ppFeedback,#feedback').slideToggle();
});