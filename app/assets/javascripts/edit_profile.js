$(document).ready(function(){

  $(document).on('click','#add_instrument', function() {    
    var instrument_id = $("[name='instruments']")[0].value;
    console.log(instrument_id);

    var proficiency = $("[name='proficiency']")[0].value;
    console.log(proficiency);
    addInstrument(instrument_id, proficiency);
  });

})

function addInstrument(instrument_id, proficiency) {
  var profile_id = $('#profile_id')[0].innerHTML;

  $.ajax({
    url: '/profile/addInstrument?instrument=' + instrument_id + '&profile=' + profile_id + '&proficiency=' + proficiency,
    type: 'POST',
    processData: false,
    success: function(data) {
      console.log(data);
    }
  });
}