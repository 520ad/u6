define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'box/compile/index' + location.search,
                    add_url: 'box/compile/add',
                    edit_url: 'box/compile/edit',
                    del_url: 'box/compile/del',
                    multi_url: 'box/compile/multi',
                    import_url: 'box/compile/import',
                    table: 'app_compile',
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
                        { checkbox: true },
                        { field: 'id', title: __('Id') },
                        { field: 'message', title: __('Message'), operate: 'LIKE', table: table, class: 'autocontent', formatter: Table.api.formatter.content },
                        { field: 'version', title: __('Version'), operate: 'LIKE' },
                        { field: 'package', title: __('Package'), operate: 'LIKE' },
                        { field: 'mtj_key', title: __('Mtj_key'), operate: 'LIKE' },
                        { field: 'mtj_canal', title: __('Mtj_canal'), operate: 'LIKE' },
                        { field: 'logo_image', title: __('Logo_image'), operate: false, events: Table.api.events.image, formatter: Table.api.formatter.image },
                        { field: 'start_image', title: __('Start_image'), operate: false, events: Table.api.events.image, formatter: Table.api.formatter.image },
                        { field: 'store_file', title: __('Store_file'), operate: false, formatter: Table.api.formatter.file },
                        { field: 'store_password', title: __('Store_password'), operate: 'LIKE', table: table, class: 'autocontent', formatter: Table.api.formatter.content },
                        { field: 'key_alias', title: __('Key_alias'), operate: 'LIKE', table: table, class: 'autocontent', formatter: Table.api.formatter.content },
                        { field: 'key_password', title: __('Key_password'), operate: 'LIKE', table: table, class: 'autocontent', formatter: Table.api.formatter.content },
                        { field: 'app_list', title: __('App_list'), searchList: { "1": __('App_list 1'), "2": __('App_list 2') }, formatter: Table.api.formatter.normal },
                        { field: 'build_type', title: __('Build_type'), searchList: { "1": __('Build_type 1'), "2": __('Build_type 2') }, formatter: Table.api.formatter.normal },
                        { field: 'updatetime', title: __('Updatetime'), operate: 'RANGE', addclass: 'datetimerange', autocomplete: false, formatter: Table.api.formatter.datetime },
                        { field: 'operate', title: __('Operate'), table: table, events: Table.api.events.operate, formatter: Table.api.formatter.operate }
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
            $('#c-authList').on('change', function () {
                Controller.authInfo();
            });
        },
        api: {
            bindevent: function () {
                Form.api.bindevent($("form[role=form]"));
            }
        },
        authInfo: function () {
            var c_msg = $('#c-msg');
            c_msg.text('查询关联信息...');
            var app_id = $('#c-id').val();
            var authid = $('#c-authList').val();
            Fast.api.ajax({
                url: 'https://ab.lvdoui.net/addons/ldauth/open',
                data: { id: authid, appid: app_id }
            }, function (data, ret) {
                if (ret.code == 1) {
                    if (ret.msg) {
                        console.log(ret.msg);
                        function setValueIfExists(selector, value) {
                            if (value) {
                                $(selector).val(value);
                            }
                        }
                        var msg = ret.msg;
                        c_msg.text(msg.msg);
                        setValueIfExists('#c-name', msg.name);
                        setValueIfExists('#c-version', msg.version);
                        setValueIfExists('#c-package', msg.package);
                        setValueIfExists('#c-adm_url', msg.adm_url);
                        setValueIfExists('#c-mtj_key', msg.mtj_key);
                        setValueIfExists('#c-mtj_canal', msg.mtj_canal);
                        setValueIfExists('#c-logo_image', msg.logo_image);
                        setValueIfExists('#c-start_image', msg.start_image);
                        setValueIfExists('#c-key_alias', msg.key_alias);
                        setValueIfExists('#c-store_file', msg.store_file);
                        setValueIfExists('#c-key_password', msg.key_password);
                        setValueIfExists('#c-store_password', msg.store_password);
                    }

                    if (ret.data) {
                        var ndkListSelect = $('#c-ndk_list');
                        var sdkListSelect = $('#c-sdk_list');
                        var buildListSelect = $('#c-build_list');
                    
                        function populateDropdown(data, selectElement, selectedIndex) {
                            selectElement.empty(); // Clear previous options
                            $.each(data, function(index, item) {
                                item = item.trim();
                                var itemObj = {
                                    value: item,
                                    text: item
                                };
                                selectElement.append($('<option>', {
                                    value: itemObj.value,
                                    text: itemObj.text
                                }));
                            });
                            selectElement.selectpicker('refresh');
                            selectElement.trigger('change');
                            if (selectedIndex !== undefined && selectedIndex >= 0) {
                                selectElement.val(selectElement.find('option').eq(selectedIndex).val());
                                selectElement.selectpicker('refresh');
                                selectElement.trigger('change');
                            }
                        }
                    
                        var ndk = ret.data[0].wares_ndk_list.split(',');
                        var sdk = ret.data[0].wares_sdk_list.split(',');
                        var build = ret.data[0].wares_build_list.split(',');

                        populateDropdown(ndk, ndkListSelect, ret.msg.ndk_key);
                        populateDropdown(sdk, sdkListSelect, ret.msg.sdk_key);
                        populateDropdown(build, buildListSelect, ret.msg.build_key);
                    }
                } else {
                    c_msg.text('查询出错:' + ret.msg);
                }
                return false;
            }, function (data, ret) {
                console.log(ret);
                return false;
            });
        },
    };
    return Controller;
});
