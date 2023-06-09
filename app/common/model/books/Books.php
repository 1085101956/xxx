<?php
declare (strict_types = 1);

namespace app\common\model\books;

use app\common\BaseModel;

class Books extends BaseModel
{
    protected $table = 'b5net_books';
    protected $deleteTime = 'delete_time';

}
