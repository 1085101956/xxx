<?php
declare (strict_types=1);

namespace app\admin\controller;

use app\admin\BaseController;
use app\admin\extend\helpers\TraitActionHelper;
use app\admin\validate\ConfigValidate;
use app\common\model\books\Books;
use app\common\model\Config;
use app\common\model\demo\Media;

class BooksController extends BaseController
{
    use TraitActionHelper;

    protected $model = Books::class;
    protected $validate = ConfigValidate::class;


}