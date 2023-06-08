<?php

declare (strict_types = 1);

namespace app\admin\controller\user;

use app\admin\BaseController;
use app\admin\extend\helpers\TraitActionHelper;
use app\common\model\user\User;


class UserController extends BaseController
{
    use TraitActionHelper;
    protected $model = User::class;


}
