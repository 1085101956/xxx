<?php
namespace app\admin\validate\books;

use think\Validate;
class BooksValidate extends Validate
{
    protected $rule = [
        'title' => 'require',
        'price' => 'require',
    ];

    protected $field = [
        'title' => '书籍名称',
        'price' => '书籍售价',
    ];
}