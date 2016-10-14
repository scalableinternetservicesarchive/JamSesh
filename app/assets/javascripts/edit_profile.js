$(document).ready(function(){

  $(document).on('click','#add_instrument', function() {    
    var instrument_id = $("[name='instruments']")[0].value;
    var proficiency = $("[name='proficiency']")[0].value;
    addInstrument(instrument_id, proficiency);
  });

})

function addInstrument(instrument_id, proficiency) {
  var profile_id = $('#profile_id')[0].innerHTML;

  $.ajax({
    url: '/profile/addInstrument?instrument=' + instrument_id + '&profile=' + profile_id + '&proficiency=' + proficiency,
    type: 'POST',
    success: function(data) {
      var instrument_row = $('#i_id-' + instrument_id);

      if (instrument_row.length) {
        $('#i_id-' + instrument_id + ' .proficiency').html(proficiency);
      }
      else {
        $('#instrument-table tbody tr:last').after('<tr><td>' + data.name + '</td><td>' + proficiency + '</td></tr>');
      }
    }
  });
}
