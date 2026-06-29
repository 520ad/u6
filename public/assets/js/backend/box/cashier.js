define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'box/cashier/index' + location.search,
                    add_url: 'box/cashier/add',
                    edit_url: 'box/cashier/edit',
                    del_url: 'box/cashier/del',
                    multi_url: 'box/cashier/multi',
                    import_url: 'box/cashier/import',
                    table: 'box_cashier',
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
                        {field: 'name', title: __('Name'), operate: 'LIKE'},
                        {field: 'key', title: __('Key'), operate: 'LIKE'},
                        {field: 'lasthearttime', title: __('Lasthearttime'), operate:'RANGE', addclass:'datetimerange', autocomplete:false, formatter: Table.api.formatter.datetime},
                        {field: 'lastpaytime', title: __('Lastpaytime'), operate:'RANGE', addclass:'datetimerange', autocomplete:false, formatter: Table.api.formatter.datetime},
                        {field: 'jkstate', title: __('Jkstate'), searchList: {"1":__('运行中'),"0":__('已掉线')}, formatter: Table.api.formatter.status},
                        {field: 'status', title: __('Status'), searchList: {"normal":__('Normal'),"hidden":__('Hidden')}, formatter: Table.api.formatter.status},
                        {
                            field: 'operate', title: __('Operate'), table: table, events: Table.api.events.operate,
                            buttons: [
                                {
                                    text: '二维码配置',
                                    title: function (row) {
                                        return "请使用收银台App扫描二维码";
                                    },
                                    classname: 'btn btn-xs btn-info btn-dialog',
                                    url: function (row) {
                                        var protocol = window.location.protocol;  
                                        var hostname = window.location.hostname;  
                                        var port = window.location.port;
                                        if (port !== "" && (protocol === "http:" && port !== "80") || (protocol === "https:" && port !== "443")) {  
                                            protocol + "//" + hostname + ":" + port;  
                                        }  
                                        return "https://cli.im/api/qrcode/code?text=" + protocol + "//" + hostname + "|" + row['id'] + "|" + row['key'];
                                    }
                                }
                            ],
                            formatter: Table.api.formatter.operate
                        }
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