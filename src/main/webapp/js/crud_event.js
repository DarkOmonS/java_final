$(document).ready(function () {
    $('#btn_add_event').click(function () {
        let event_name = $('#event_name').val()
        let event_description = $('#event_description').val()
        if (event_name.length <= 0 || event_description.length < 10) {
            $('#add_event_feedback').removeClass('d-none alert-success').addClass('alert-danger').text('Please fill all fields correctly')
            return
        }
        $.ajax({
            url: 'eventCRUDServlet',
            type: 'post',
            data: {event_crud_type: 'add', name: event_name, description: event_description},
            success: function (data) {
                if (data === 'True') {
                    location.reload()
                    $('#add_event_feedback').removeClass('d-none alert-danger').addClass('alert-success').text('Event added')
                }
            }
        })
    });

    $('#btn_edit_event').click(function () {
        let event_id = $('#event_id').val()
        let event_name = $('#event_name').val()
        let event_description = $('#event_description').val()
        if (event_name.length <= 0 || event_description.length < 10) {
            $('#add_event_feedback').removeClass('d-none alert-success').addClass('alert-danger').text('Please fill all fields correctly')
            return
        }
        $.ajax({
            url: 'eventCRUDServlet',
            type: 'post',
            data: {event_crud_type: 'update', id: event_id, name: event_name, description: event_description},
            success: function (data) {
                if (data === 'True') {
                    location.reload()
                    $('#add_event_feedback').removeClass('d-none alert-danger').addClass('alert-success').text('Event updated')
                }
            }
        })
    });

    $('.edit_event').click(function () {
        let event_id = $(this).data('id')
        $.ajax({
            url: 'eventCRUDServlet',
            type: 'get',
            data: {id: event_id},
            success: function (data) {
                $('#event_id').val(event_id)
                $('#event_name').val(data.name)
                $('#event_description').val(data.description)
            }
        })
    });

    $('.delete_event').click(function () {
        let event_id = $(this).data('id')
        $.ajax({
            url: 'eventCRUDServlet',
            type: 'post',
            data: {event_crud_type: 'delete', id: event_id},
            success: function (data) {
                if (data === 'True') {
                    location.reload()
                    $('#event_delete_feedback').removeClass('d-none').text('Event deleted')
                }
            }
        })
    })
});