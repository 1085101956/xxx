<?php

declare (strict_types = 1);

namespace app\admin\controller;

use app\admin\BaseController;
use app\admin\extend\helpers\TraitActionHelper;
use app\common\model\Notice;


class NoticeController extends BaseController
{
    use TraitActionHelper;
    protected $model = Notice::class;


}
