define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'box/home/index' + location.search,
                    add_url: 'box/home/add',
                    edit_url: 'box/home/edit',
                    del_url: 'box/home/del',
                    multi_url: 'box/home/multi',
                    import_url: 'box/home/import',
                    table: 'box_home',
                }
            });

            var table = $("#table");
            function getSearchListRows() {  
                return new Promise((resolve, reject) => {  
                    $.getJSON("box/app/index", function(data) {  
                        resolve(data.rows);  
                    });  
                });  
            }
            // 初始化表格
            table.bootstrapTable({
                url: $.fn.bootstrapTable.defaults.extend.index_url,
                pk: 'id',
                sortName: 'weigh',
                fixedColumns: true,
                fixedRightNumber: 1,
                columns: [
                    [
                        {checkbox: true},
                        {field: 'id', title: __('Id')},
                        {field: 'box_app_ids', title: __('Box_app_ids'), operate: 'LIKE', table: table, class: 'autocontent', formatter: Table.api.formatter.content, searchList: getSearchListRows()},
                        {field: 'title', title: __('Title'), operate: 'LIKE'},
                        {field: 'subtitle', title: __('Subtitle'), operate: 'LIKE'},
                        {field: 'parameter', title: __('Parameter'), operate: 'LIKE'},
                        {field: 'coverimage', title: __('Coverimage'), operate: false, events: Table.api.events.image, formatter: Table.api.formatter.image},
                        {field: 'createtime', title: __('Createtime'), operate:'RANGE', addclass:'datetimerange', autocomplete:false, formatter: Table.api.formatter.datetime},
                        {field: 'updatetime', title: __('Updatetime'), operate:'RANGE', addclass:'datetimerange', autocomplete:false, formatter: Table.api.formatter.datetime},
                        {field: 'weigh', title: __('Weigh'), operate: false},
                        {field: 'status', title: __('Status'), searchList: {"normal":__('Normal'),"hidden":__('Hidden')}, formatter: Table.api.formatter.status},
                        {field: 'operate', title: __('Operate'), table: table, events: Table.api.events.operate, formatter: Table.api.formatter.operate}
                    ]
                ]
            });

            // 为表格绑定事件
            Table.api.bindevent(table);
        },
 

        add: function () {
            Controller.api.bindevent();
        },
        edit: function () {
            Controller.api.bindevent();
        },
        api: {
            bindevent: function () {
                Form.api.bindevent($("form[role=form]"));
            }
        }
    };
    return Controller;
});
