<?php

declare (strict_types = 1);

namespace app\admin\controller\user;

use app\admin\BaseController;
use app\admin\extend\helpers\TraitActionHelper;
use app\common\helpers\ExportHelper;
use app\common\helpers\Result;
use app\common\model\user\User;
use app\Request;
use think\facade\Db;


class UserController extends BaseController
{
    use TraitActionHelper;
    protected $model = User::class;
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
            return $this->editRender($info,$request);
        }
    }

}
