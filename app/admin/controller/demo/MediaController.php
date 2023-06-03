<?php

declare (strict_types = 1);

namespace app\admin\controller\demo;

use app\admin\BaseController;
use app\admin\extend\helpers\TraitActionHelper;
use app\admin\validate\RoleValidate;
use app\common\model\demo\Media;


class MediaController extends BaseController
{
    use TraitActionHelper;
    protected $model = Media::class;
    protected $validate = RoleValidate::class;

}
