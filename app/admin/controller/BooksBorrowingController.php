<?php

declare (strict_types = 1);

namespace app\admin\controller;

use app\admin\BaseController;
use app\admin\extend\helpers\TraitActionHelper;
use app\common\helpers\ExportHelper;
use app\common\helpers\Result;
use app\common\model\BooksBorrowing;
use app\Request;
use think\facade\Db;


class BooksBorrowingController extends BaseController
{
    use TraitActionHelper;
    protected $model = BooksBorrowing::class;
    public function indexAction(Request $request)
    {
        if ($request->isPost()) {
            $params = $request->post();
            if (method_exists($this, 'indexBefore')) {
                $params = $this->indexBefore($params);
            }
            //是否是树形tree，展示所有数据
            $isTree = $params['isTree'] ?? 0;

            //是否为导出excel，展示所有数据
            $isExport = $params['isExport'] ?? 0;

            $query = Db::table($this->model::tableName());
//            $query->leftJoin('b5net_books','')
            $query = $this->indexWhere($query, $params);

            //操作查询对象，可以进行语句处理以及数据权限处理
            $extend = [];
            $queryResult = $this->indexQuery($query);
            if(is_array($queryResult)){
                $query = $queryResult['query'];
                $extend = $queryResult['extend']??[];
            }else{
                $query = $queryResult;
            }

            //是否分页
            if (!$isTree && !$isExport) {
                $pageSize = intval($params['pageSize'] ?? 10);
                $pageNum = intval($params['pageNum'] ?? 1);
                $pageNum = $pageNum < 1 ? 1 : $pageNum;
                $count = $query->count();
                $query = $query->page($pageNum, $pageSize);
            }
            $list = $query->select()->toArray();
            if ($isTree || $isExport) {
                $count = count($list);
            }
            //结果查询后的处理
            if (method_exists($this, 'indexAfter')) {
                $list = $this->indexAfter($list);
            }

            //导出操作
            if($isExport){
                //结果查询后的处理
                $export_data = $this->exportBefore($list);
                $excel_path = (new ExportHelper($export_data))->export();
                return Result::success($excel_path);
            }else{
                return Result::success('', $list, ['total' => $count,'extend'=>$extend]);
            }
        } else {
            return $this->indexRender($request);
        }
    }

    public function addAction(Request $request)
    {
        if ($request->isPost()) {
            $data = $request->post();
            $session = session();
            $user = Db::table("b5net_user")
                ->field('id,username,phone,library_card,purchase,price,borrowing')
                ->where('status',0)
                ->where('id',$data['id'])
                ->find();
            $data['user_id'] = $user['id'];
            $data['username'] = $user['username'];
            $data['phone'] = $user['phone'];
            $data['admin_id'] = $session['adminLoginInfo']['info']['id'];
            $data['struct_id'] = $session['adminLoginInfo']['struct'][0]['id'];
            $all = Db::table('b5net_books')
                ->field('id,code,borrowing,number,sales_number,price')
                ->where('id',$data['code'])
                ->find();
            $data['code'] = $all['code'];
            $data['code'] = $user['library_card'];
            unset($data['id']);
            if ( $data['type'] == 2 ) {
                Db::table('b5net_books')->where('id',$all['id'])->update(['sales_number' => $all['sales_number'] +1,'number' => $all['number'] -1]);
                Db::table('b5net_user')->where('id',$user['id'])->update(['purchase' => $user['purchase'] +1,'price' => $user['price'] + $all['price']]);
            } else {
                Db::table('b5net_books')->where('id',$all['id'])->update(['borrowing' => $all['borrowing'] + 1,'number' => $all['number'] -1]);
                Db::table('b5net_books')->where('id',$all['id'])->update(['borrowing' => $user['borrowing'] +1 ]);
            }
            $data['books_id'] = $all['id'];
            //验证
            if ($this->validate ?? false) {
                //验证前数据处理
                $data = $this->validateBefore($data,'add');
                if(!is_array($data)){
                    return Result::error($data);
                }
                $res = validate($this->validate)->scene('add')->check($data);
                if ($res !== true) {
                    return Result::error($res);
                }
            }
            //数据处理
            $data = $this->saveBefore($data,'add');
            if(!is_array($data)){
                return Result::error($data);
            }
            $result = $this->model::bInsert($data,true);
            if (!$result) {
                return Result::error('保存失败');
            }

            $pk = $this->model::primaryKey();
            if ($pk) {
                $data[$pk] = $result;
            }
            $this->saveAfter($data, 'add');
            return Result::success('保存成功');
        } else {
            return $this->addRender($request);
        }
    }
    protected function addRender(Request $request):string{
        $query = Db::table("b5net_user")->field('id,username as name,phone,library_card')->where('status',0)->select()->toArray();
        foreach ( $query as $key => &$value ) {
            $value['name'] = $value['name'].'-'.$value['phone'].'-'.$value['library_card'];
        }
        $list = Db::table('b5net_books')->field("id,title as name,code")->where('status',0)->select()->toArray();
        foreach ( $list as &$item ) {
            $item['name'] = $item['name'].'-'.$item['code'];
        }
        return $this->render('', ['input' => $request->get(),'posList' => $query,'booksList' => $list]);
    }


    public function editAction(Request $request)
    {
        if ($request->isPost()) {
            $data = $request->post();
            //验证
            if ($this->validate ?? false) {
                //验证前数据处理
                $data = $this->validateBefore($data,'edit');
                if(!is_array($data)){
                    return Result::error($data);
                }

                $res = validate($this->validate)->scene('edit')->check($data);
                if ($res !== true) {
                    return Result::error($res);
                }
            }
            //数据预处理
            $data = $this->saveBefore($data,'edit');
            if(!is_array($data)){
                return Result::error($data);
            }

            $result = $this->model::bUpdate($data);
            if ($result === false) {
                return Result::error('保存失败');
            }
            if ($result) {
                $this->saveAfter($data, 'edit');
            }
            return Result::success('保存成功');
        } else {
            $id = $request->get('id',0);
            if (!$id) {
                return $this->toError('参数错误');
            }
            $info = $this->model::bFind($id);
            if (!$info) {
                return $this->toError('信息不存在');
            }
//            var_dump($info);

            return $this->editRender($info,$request);
        }
    }
    protected function editRender(array $info,Request $request ):string{
        $list = Db::table("b5net_user")
            ->field('username,phone,library_card')
            ->where('id',$info['user_id'])
            ->find();
        return $this->render('', ['input' => $request->get(),'username' => $list['username'].'-'.$list['phone'].'-'.$list['library_card'], 'info' => $info]);
    }

}
