$(function() {
  $('#add-member-button').click(function() {
    // profile id of selected member to add
    var selected_member = $('#add-member-dropdown').val();
    if (selected_member != null && selected_member > 0) {
      $.post('/jam_group_members', {
        'profile': selected_member, 
        'jam_group': $(this).data('jamgroupid'),
      });
    } else {
      $('#add-member-warning').toggleClass("show hidden");
    }
  });
});
