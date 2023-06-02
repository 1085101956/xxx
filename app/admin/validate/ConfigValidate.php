<?php
namespace app\admin\validate;

use app\admin\extend\services\ConfigService;
use think\Validate;

class ConfigValidate extends Validate
{
    protected $rule = [
        'title' => 'require|min:2|max:50',
        'type' => 'require|min:2|max:30|alphaDash|unique:b5net_config',
        'style' => 'require|checkStyle',
        'extra'=>'max:255',
        'note'=>'max:255',
    ];

    protected $field=[
        'title' => '配置标题',
        'style' => '配置类型',
        'type' => '配置标识',
        'extra' => '配置项',
        'note' => '备注',
    ];

    public function checkStyle($value){
        $styleList = (new ConfigService())->styleList();
        return isset($styleList[$value])?true:'配置类型错误';
    }
}
