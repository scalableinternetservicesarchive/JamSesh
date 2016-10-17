$(document).ready(function(){

  $(document).on('click','#add_instrument', function() {    
    var instrument_id = $("[name='instruments']")[0].value;
    var proficiency = $("[name='proficiency']")[0].value;
    addInstrument(instrument_id, proficiency);
  });
  
  $(document).on('click', '.edit_instrument', function(event) {
    var instrument_id = event.target.id.split('-').pop();
    var proficiency = $('#i_id-' + instrument_id + ' .proficiency .current-proficiency')[0].innerText;

    $('#i_id-' + instrument_id + ' .proficiency').html(
      '<select id="proficiency-i_id-' 
      + instrument_id 
      + '" class="form-control">'
      + '<option value="Newb">Newb</option>'
      + '<option value="Beginner">Beginner</option>'
      + '<option value="Novice">Novice</option>'
      + '<option value="Intermediate">Intermediate</option>'
      + '<option value="Experienced">Experienced</option>'
      + '<option value="Expert">Expert</option>'
      + '<option value="Virtuoso">Virtuoso</option>'
      + '</select>'
      + '<button type="button" id="update-i_id-' + instrument_id + '" class="btn btn-primary update_instrument">Update</button>'
    );
    $('#proficiency-i_id-' + instrument_id)[0].value = proficiency;
  });
  
  $(document).on('click', '.update_instrument', function(event) {
    var instrument_id = event.target.id.split('-').pop();
    var proficiency =$('#proficiency-i_id-' + instrument_id)[0].value;
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
        $('#i_id-' + instrument_id + ' .proficiency').html(
          '<span class="current-proficiency">' + proficiency + '</span>' 
          + '<button type="button" id="edit-i_id-' + instrument_id + '" class="btn btn-primary edit_instrument">Edit</button>'
        );
      }
      else {
        $('#instrument-table tbody').append(
          '<tr id="i_id-' + instrument_id + '">'
          + '<td class="table-content instrument">' + data.name + '</td>'
          + '<td class="table-content proficiency">' 
          + '<span class="current-proficiency">' + proficiency + '</span>'
          + '<button type="button" id="edit-i_id-' + instrument_id + '" class="btn btn-primary edit_instrument">Edit</button>'
          + '</td></tr>');
      }
    }
  });
}
