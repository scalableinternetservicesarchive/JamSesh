//=require jquery

$(document).ready(function(){

  console.log($(document));
	// console.log('ready');
	// console.log($('#add_instrument'));
	$('#add_instrument').click(function(event) {    
    var instrument_id = $("[name='instruments']")[0].value;
    console.log(instrument_id);

    var proficiency = $("[name='proficiency']")[0].value;
    console.log(proficiency);
    addInstrument(instrument_id, proficiency);
	});
})

function addInstrument(instrument_id, proficiency) {
	console.log('add instrument');

  var profile_id = 0;

  $.ajax({
    url: '/profile/addInstrument?instrument=' + instrument_id + '&profile=' + profile_id + '&proficiency=' + proficiency,
    type: 'POST',
    processData: false,
    success: function(data) {
      console.log(data);
    }
  });
}

/*if (document.querySelector('#add_instrument')) {
  document.querySelector('#add_instrument').addEventListener("click", addInstrument());
}*/