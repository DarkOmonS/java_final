$(document).ready(function () {
    $('#btn_add_club').click(function () {
        let club_name = $('#club_name').val()
        let club_description = $('#club_description').val()
        if (club_name.length <= 0 || club_description.length < 10) {
            $('#add_club_feedback').removeClass('d-none alert-success').addClass('alert-danger').text('Please fill all fields correctly')
            return
        }
        $.ajax({
            url: 'ClubCRUDServlet',
            type: 'post',
            data: {club_crud_type: 'add', name: club_name, description: club_description},
            success: function (data) {
                if (data === 'True') {
                    location.reload()
                    $('#add_club_feedback').removeClass('d-none alert-danger').addClass('alert-success').text('Club added')
                }
            }
        })
    });

    $('#btn_edit_club').click(function () {
        let club_id = $('#club_id').val()
        let club_name = $('#club_name').val()
        let club_description = $('#club_description').val()
        if (club_name.length <= 0 || club_description.length < 10) {
            $('#add_club_feedback').removeClass('d-none alert-success').addClass('alert-danger').text('Please fill all fields correctly')
            return
        }
        $.ajax({
            url: 'ClubCRUDServlet',
            type: 'post',
            data: {club_crud_type: 'update', id: club_id, name: club_name, description: club_description},
            success: function (data) {
                if (data === 'True') {
                    location.reload()
                    $('#add_club_feedback').removeClass('d-none alert-danger').addClass('alert-success').text('Club updated')
                }
            }
        })
    });

    $('.edit_club').click(function () {
        let club_id = $(this).data('id')
        $.ajax({
            url: 'ClubCRUDServlet',
            type: 'get',
            data: {id: club_id},
            success: function (data) {
                $('#club_id').val(club_id)
                $('#club_name').val(data.name)
                $('#club_description').val(data.description)
            }
        })
    });

    $('.delete_club').click(function () {
        let club_id = $(this).data('id')
        $.ajax({
            url: 'ClubCRUDServlet',
            type: 'post',
            data: {club_crud_type: 'delete', id: club_id},
            success: function (data) {
                if (data === 'True') {
                    location.reload()
                    $('#club_add_feedback').removeClass('d-none alert-danger').addClass('alert-success').text('Club deleted')
                }
            }
        })
    })
});