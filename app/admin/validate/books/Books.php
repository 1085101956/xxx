<?php
namespace app\admin\validate\books;

use think\Validate;
class Books extends Validate
{
    protected $rule = [
        'username' => 'require|min:2|max:30|alphaDash|unique:b5net_admin',
        'struct' => 'require',
        'roles' => 'require',
        'password' => 'min:6|max:30',
        'realname' => 'min:2|max:30',
        'status' => 'require|integer|in:0,1',
        'note' => 'max:255',
    ];

    protected $field = [
        'username' => '登陆账号',
        'struct' => '组织部门',
        'roles' => '角色分组',
        'password' => '登录密码',
        'realname' => '真实姓名',
        'status' => '状态',
        'note' => '备注'
    ];
}