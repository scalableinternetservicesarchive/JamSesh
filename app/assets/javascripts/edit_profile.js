$(document).ready(function(){

  $(document).on('click','#add_instrument', function() {    
    var instrument_id = $("[name='instruments']")[0].value;
    var proficiency = $("[name='proficiency']")[0].value;
    var owned = $("[name='owned']")[0].value;
    addInstrument(instrument_id, proficiency, owned);
  });
  
  $(document).on('click', '.edit_instrument', function(event) {
    var instrument_id = event.target.id.split('-').pop();
    var proficiency = $('#i_id-' + instrument_id + ' .proficiency .current-proficiency')[0].innerText;
    var owned = $('#i_id-' + instrument_id + ' .current-own-status')[0].innerText == 'Yes' ? "true" : "false";
    
    $('#proficiency-i_id-' + instrument_id).val(proficiency);
    $('#own-i_id-' + instrument_id).val(owned);
    
    $('#i_id-' + instrument_id + ' .showing-instrument').addClass('hidden');
    $('#i_id-' + instrument_id + ' .editing-instrument').removeClass('hidden');
  });
  
  $(document).on('click', '.update_instrument', function(event) {
    var instrument_id = event.target.id.split('-').pop();
    var proficiency =$('#proficiency-i_id-' + instrument_id)[0].value;
    var owned = $('#own-i_id-' + instrument_id)[0].value;
    addInstrument(instrument_id, proficiency, owned);
  });
  
  $(document).on('click', '.cancel_update', function(event) {
    var instrument_id = event.target.id.split('-').pop();
    
    $('#i_id-' + instrument_id + ' .showing-instrument').removeClass('hidden');
    $('#i_id-' + instrument_id + ' .editing-instrument').addClass('hidden');
  });
  
  $(document).on('click', '.remove_instrument', function(event) {
    var instrument_id = event.target.id.split('-').pop();
    removeInstrument(instrument_id);
  });

})

function addInstrument(instrument_id, proficiency, owned) {
  var profile_id = $('#profile_id')[0].innerHTML;

  $.ajax({
    url: '/profile/addInstrument?instrument=' + instrument_id + '&profile=' + profile_id + '&proficiency=' + proficiency + "&owned=" + owned,
    type: 'POST',
    success: function(data) {
      var instrument_row = $('#i_id-' + instrument_id);
      var owned_string = owned == "true" ? "Yes" : "No";
      
      if (instrument_row.length) {
        $('#i_id-' + instrument_id + ' .current-proficiency').text(proficiency);
        $('#i_id-' + instrument_id + ' .current-own-status').text(owned_string);
        
        $('#i_id-' + instrument_id + ' .showing-instrument').removeClass('hidden');
        $('#i_id-' + instrument_id + ' .editing-instrument').addClass('hidden');
      }
      else {
        addInstrumentRow(instrument_id, data.name, proficiency, owned_string);
      }
    }
  });
}

function addInstrumentRow(instrument_id, instrument_name, proficiency, owned_string) {
  $('#instrument-table tbody').append(
    
    '<tr id="i_id-' + instrument_id + '">'
    + '<td class="table-content instrument">' + instrument_name + '</td>'
    + '<td class="table-content proficiency">' 
      + '<div class="showing-instrument">'
        + '<span class="current-proficiency">' + proficiency + '</span>'
      + '</div>'
            
      + '<div class="editing-instrument hidden">'
        + '<select id="proficiency-i_id-' + instrument_id + '" class="form-control" style="width: auto; display: inline;">'
          + '<option value="Newb">Newb</option>'
          + '<option value="Beginner">Beginner</option>'
          + '<option value="Novice">Novice</option>'
          + '<option value="Intermediate">Intermediate</option>'
          + '<option value="Experienced">Experienced</option>'
          + '<option value="Expert">Expert</option>'
          + '<option value="Virtuoso">Virtuoso</option>'
        + '</select>'
      + '</div>'
    + '</td>'
    
    + '<td class="table-content own-instrument">'
      + '<div class="showing-instrument">'
        + '<span class="current-own-status">' + owned_string + '</span>'
      + '</div>'
      + '<div class="editing-instrument hidden">'
        + '<select id="own-i_id-' + instrument_id + '" class="form-control">'
          + '<option value="false">No</option>'
          + '<option value="true">Yes</option>'
        + '</select>'
      + '</div>'
    + '</td>'
                
    + '<td class="table-content actions">'
      + '<div class="showing-instrument">'
        + '<button type="button" id="edit-i_id-' + instrument_id + '" class="btn btn-primary edit_instrument">Edit</button>'
        + '\n'
        + '<button type="button" id="remove-i_id-' + instrument_id + '" class="btn btn-primary remove_instrument">Remove</button>'
      + '</div>'
      + '<div class="editing-instrument hidden">'
        + '<button type="button" id="update-i_id-' + instrument_id + '" class="btn btn-primary update_instrument">Update</button>'
        + '\n'
        + '<button type="button" id="cancel-i_id-' + instrument_id + '" class="btn btn-primary cancel_update">Cancel</button>'
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