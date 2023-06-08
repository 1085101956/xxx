<?php

declare (strict_types = 1);

namespace app\admin\controller;

use app\admin\BaseController;
use app\admin\extend\helpers\TraitActionHelper;
use app\common\model\BooksBorrowing;


class BooksBorrowingController extends BaseController
{
    use TraitActionHelper;
    protected $model = BooksBorrowing::class;


}
