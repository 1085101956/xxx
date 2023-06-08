<?php

declare (strict_types = 1);

namespace app\admin\controller\borrowing;

use app\admin\BaseController;
use app\admin\extend\helpers\TraitActionHelper;
use app\common\model\borrowing\CooksBorrowing;


class CooksBorrowingController extends BaseController
{
    use TraitActionHelper;
    protected $model = CooksBorrowing::class;


}
