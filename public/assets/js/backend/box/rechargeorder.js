define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'box/rechargeorder/index' + location.search,
                    add_url: 'box/rechargeorder/add',
                    edit_url: 'box/rechargeorder/edit',
                    del_url: 'box/rechargeorder/del',
                    multi_url: 'box/rechargeorder/multi',
                    import_url: 'box/rechargeorder/import',
                    table: 'recharge_order',
                }
            });

            var table = $("#table");

            // 初始化表格
            table.bootstrapTable({
                url: $.fn.bootstrapTable.defaults.extend.index_url,
                pk: 'id',
                sortName: 'id',
                fixedColumns: true,
                fixedRightNumber: 1,
                columns: [
                    [
                        {checkbox: true},
                        {field: 'id', title: __('Id')},
                        {field: 'orderid', title: __('Orderid'), operate: 'LIKE'},
                        {field: 'user_id', title: __('User_id')},
                        {field: 'amount', title: __('Amount'), operate:'BETWEEN'},
                        {field: 'allocationamount', title: __('分配金额'), operate:'BETWEEN'},
                        {field: 'payamount', title: __('Payamount'), operate:'BETWEEN'},
                        {field: 'paytype', title: __('Paytype'), operate: 'LIKE'},
                        {field: 'paytime', title: __('Paytime'), operate:'RANGE', addclass:'datetimerange', autocomplete:false, formatter: Table.api.formatter.datetime},
                        {field: 'ip', title: __('Ip'), operate: 'LIKE'},
                        // {field: 'useragent', title: __('Useragent'), operate: 'LIKE', table: table, class: 'autocontent', formatter: Table.api.formatter.content},
                        {field: 'memo', title: __('Memo'), operate: 'LIKE', table: table, class: 'autocontent', formatter: Table.api.formatter.content},
                        {field: 'createtime', title: __('Createtime'), operate:'RANGE', addclass:'datetimerange', autocomplete:false, formatter: Table.api.formatter.datetime},
                        // {field: 'updatetime', title: __('Updatetime'), operate:'RANGE', addclass:'datetimerange', autocomplete:false, formatter: Table.api.formatter.datetime},
                        {field: 'status', title: __('Status'), searchList: {"created":__('Created'),"paid":__('Paid'),"expired":__('Expired')}, formatter: Table.api.formatter.status},
                        {field: 'operate', title: __('Operate'), table: table, events: Table.api.events.operate, 
                        buttons: [
                            {
                                text: '补单',
                                title: function (row) {
                                    return "补单";
                                },
                                classname: 'btn btn-xs btn-info btn-dialog ',
                                url: function (row) {
                                    var domain = document.domain;
                                    return "//"+domain+"/api/cashier/pushOrders?&orderid=" + row['orderid'];
                                },
                            }
                        ],
                        formatter: Table.api.formatter.operate}
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
