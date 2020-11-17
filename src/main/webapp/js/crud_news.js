$(document).ready(function () {
    $('#btn_add_news').click(function () {
        let news_name = $('#news_name').val()
        let news_description = $('#news_description').val()
        if (news_name.length <= 0 || news_description.length < 10) {
            $('#add_news_feedback').removeClass('d-none alert-success').addClass('alert-danger').text('Please fill all fields correctly')
            return
        }
        $.ajax({
            url: 'news_CRUD_servlet',
            type: 'post',
            data: {news_crud_type: 'add', name: news_name, description: news_description},
            success: function (data) {
                if (data === 'True') {
                    location.reload()
                    $('#add_news_feedback').removeClass('d-none alert-danger').addClass('alert-success').text('News added')
                }
            }
        })
    });

    $('#btn_edit_news').click(function () {
        let news_id = $('#news_id').val()
        let news_name = $('#news_name').val()
        let news_description = $('#news_description').val()
        if (news_name.length <= 0 || news_description.length < 10) {
            $('#add_news_feedback').removeClass('d-none alert-success').addClass('alert-danger').text('Please fill all fields correctly')
            return
        }
        $.ajax({
            url: 'news_CRUD_servlet',
            type: 'post',
            data: {news_crud_type: 'update', id: news_id, name: news_name, description: news_description},
            success: function (data) {
                if (data === 'True') {
                    location.reload()
                    $('#add_news_feedback').removeClass('d-none alert-danger').addClass('alert-success').text('News updated')
                }
            }
        })
    });

    $('.edit_news').click(function () {
        let news_id = $(this).data('id')
        $.ajax({
            url: 'news_CRUD_servlet',
            type: 'get',
            data: {id: news_id},
            success: function (data) {
                $('#news_id').val(news_id)
                $('#news_name').val(data.name)
                $('#news_description').val(data.description)
            }
        })
    });

    $('.delete_news').click(function () {
        let news_id = $(this).data('id')
        $.ajax({
            url: 'news_CRUD_servlet',
            type: 'post',
            data: {news_crud_type: 'delete', id: news_id},
            success: function (data) {
                if (data === 'True') {
                    location.reload()
                    $('#news_delete_feedback').removeClass('d-none').text('News deleted')
                }
            }
        })
    })
});