<?php

declare (strict_types = 1);

namespace app\admin\controller;

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

    function create_trade_no($prefix='ZS')
    {
        return $prefix . date('Ymd', time()) . sprintf('%03d', rand(0, 9999));
    }
    /**
     * 公共新增action
     * @param Request $request
     * @return string|\think\response\Json
     */
    public function addAction(Request $request)
    {
        if ($request->isPost()) {
            $data = $request->post();
            $data['library_card'] = $this->create_trade_no();
            $data['borrowing'] = 0;
            $data['purchase'] = 0;
            $data['price'] = '0.00';
            $data['create_time'] = date('Y-m-d H:i:s',time());
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

}
