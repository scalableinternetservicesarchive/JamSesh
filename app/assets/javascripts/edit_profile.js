$(document).ready(function(){

  $(document).on('click','#add_instrument', function() {    
    var instrument_id = $("[name='instruments']")[0].value;
    var proficiency = $("[name='proficiency']")[0].value;
    addInstrument(instrument_id, proficiency);
  });
  
  $(document).on('click', '.edit_instrument', function(event) {
    var instrument_id = event.target.id.split('-').pop();
    var proficiency = $('#i_id-' + instrument_id + ' .proficiency .current-proficiency')[0].innerText;
    
    $('#i_id-' + instrument_id + ' .show-proficiency').addClass('hidden');
    $('#i_id-' + instrument_id + ' .update-proficiency').removeClass('hidden');
    
    $('#proficiency-i_id-' + instrument_id).val(proficiency);
  });
  
  $(document).on('click', '.update_instrument', function(event) {
    var instrument_id = event.target.id.split('-').pop();
    var proficiency =$('#proficiency-i_id-' + instrument_id)[0].value;
    addInstrument(instrument_id, proficiency);
  });
  
  $(document).on('click', '.remove_instrument', function(event) {
    var instrument_id = event.target.id.split('-').pop();
    removeInstrument(instrument_id);
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
        $('#i_id-' + instrument_id + ' .show-proficiency').removeClass('hidden');
        $('#i_id-' + instrument_id + ' .update-proficiency').addClass('hidden');
        
        $('#i_id-' + instrument_id + ' .current-proficiency').text(proficiency);
      }
      else {
        addInstrumentRow(instrument_id, data.name, proficiency);
      }
    }
  });
}

function addInstrumentRow(instrument_id, instrument_name, proficiency) {
  $('#instrument-table tbody').append(
    // '<tr id="i_id-' + instrument_id + '">'
    // + '<td class="table-content instrument">' + instrument_name + '</td>'
    // + '<td class="table-content proficiency">' 
    // + '<span class="current-proficiency">' + proficiency + '</span>'
    // + '<button type="button" id="edit-i_id-' + instrument_id + '" class="btn btn-primary edit_instrument">Edit</button>'
    // + '</td></tr>');
    
    '<tr id="i_id-' + instrument_id + '">'
    + '<td class="table-content instrument">' + instrument_name + '</td>'
    + '<td class="table-content proficiency">' 
    + '<div class="show-proficiency">'
    + '<span class="current-proficiency">' + proficiency + '</span>'
    + '\n'
    + '<button type="button" id="edit-i_id-' + instrument_id + '" class="btn btn-primary edit_instrument">Edit</button>'
    + '\n'
    + '<button type="button" id="remove-i_id-' + instrument_id + '" class="btn btn-primary remove_instrument">Remove</button>'
    + '</div>'
            
    + '<div class="update-proficiency hidden">'
    + '<select id="proficiency-i_id-' + instrument_id + '" class="form-control" style="width: auto; display: inline;">'
    + '<option value="Newb">Newb</option>'
    + '<option value="Beginner">Beginner</option>'
    + '<option value="Novice">Novice</option>'
    + '<option value="Intermediate">Intermediate</option>'
    + '<option value="Experienced">Experienced</option>'
    + '<option value="Expert">Expert</option>'
    + '<option value="Virtuoso">Virtuoso</option>'
    + '</select>'
    + '\n'
    + '<button type="button" id="update-i_id-' + instrument_id + '" class="btn btn-primary update_instrument">Update</button>'
    + '</div>'
    + '</td>'
    + '</tr>'
  );
}

function removeInstrument(instrument_id) {
  var profile_id = $('#profile_id')[0].innerHTML;

  $.ajax({
    url: '/profile/removeInstrument?instrument=' + instrument_id + '&profile=' + profile_id,
    type: 'DELETE',
    success: function(data) {
      var instrument_row = $('#i_id-' + instrument_id);
      if (instrument_row){
        instrument_row.remove();
      }
    }
  });
}