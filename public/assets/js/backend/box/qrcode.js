define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'box/qrcode/index' + location.search,
                    add_url: 'box/qrcode/add',
                    edit_url: 'box/qrcode/edit',
                    del_url: 'box/qrcode/del',
                    multi_url: 'box/qrcode/multi',
                    import_url: 'box/qrcode/import',
                    table: 'box_qrcode',
                }
            });

            var table = $("#table");

            // 初始化表格
            table.bootstrapTable({
                url: $.fn.bootstrapTable.defaults.extend.index_url,
                pk: 'id',
                sortName: 'id',
                columns: [
                    [
                        {checkbox: true},
                        {field: 'id', title: __('Id')},
                        {field: 'price', title: __('Price'), operate:'BETWEEN'},
                        {field: 'qrcode', title: __('Qrcode'), operate: 'LIKE', table: table, class: 'autocontent', formatter: Table.api.formatter.content},
                        {field: 'codedata', title: __('Codedata'), searchList: {"currency":__('Codedata currency'),"regular":__('Codedata regular')}, formatter: Table.api.formatter.normal},
                        {field: 'platformdata', title: __('Platformdata'), searchList: {"wechat":__('Platformdata wechat'),"alipay":__('Platformdata alipay')}, formatter: Table.api.formatter.normal},
                        {field: 'statusswitch', title: __('Statusswitch'), searchList: {"1":__('Yes'),"0":__('No')}, table: table, formatter: Table.api.formatter.toggle},
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
