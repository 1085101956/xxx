<?php
namespace app\admin\validate;

use think\Validate;

class PositionValidate extends Validate
{
    protected $rule = [
        'name|岗位名称'=>'require|min:2|max:30',
        'poskey|岗位标识' => 'require|min:2|max:30',
        'listsort|显示顺序'=>'require|integer',
        'status|菜单状态'=>'require|integer|in:0,1',
        'note|备注'=>'max:255',
    ];

}
