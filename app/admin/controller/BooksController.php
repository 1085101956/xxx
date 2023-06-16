<?php
declare (strict_types=1);

namespace app\admin\controller;

use app\admin\BaseController;
use app\admin\extend\helpers\TraitActionHelper;
use app\admin\validate\books\BooksValidate;
use app\common\helpers\ExportHelper;
use app\common\helpers\Result;
use app\common\model\books\Books;
use app\common\model\Role;
use app\Request;
use think\facade\Config;
use think\facade\Db;

class BooksController extends BaseController
{
    use TraitActionHelper;

    protected $model = Books::class;
    protected $validate = BooksValidate::class;
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
            $query = $query->alias('a')
                ->field('a.id,a.title,a.create_time,a.status,a.price,a.borrowing,a.number,a.introduce,a.image,a.press,a.pages,a.publish_date,a.author,b.name');
            $query = $query->leftJoin('b5net_cate b','a.cate_id = b.id');
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
            foreach ( $list as &$item ) {
                if ( mb_strlen($item['introduce']) > 20 ) {
                    $item['introduce'] = mb_substr($item['introduce'],0,20).'...';
                }
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
    /**
     * 首页渲染
     * @return string
     */
    protected function indexRender(): string
    {
        $root_id = Config::get('system.root_admin_id');
        $posList = Db::table("b5net_cate")->where('status',0)->select()->toArray();
        return $this->render('', ['root_id' => $root_id,'posList' => $posList]);
    }
    protected function addRender(Request $request):string{
        $posList = Db::table("b5net_cate")->where('status',0)->select()->toArray();
        return $this->render('', ['input' => $request->get(),'posList' => $posList]);
    }

    /**
     * 将处理首页的过程 单独提取，便于自定义indexAction时使用
     * @param $query
     * @param $params
     * @return mixed
     * @throws \Exception
     */
    protected function indexWhere($query, $params)
    {
        $orderBy = $params['orderBy']??[];//自定义的排序
        $orderByColumn = empty($params['orderByColumn']) ? '' : $params['orderByColumn'];
        $isAsc = empty($params['isAsc']) ? 'desc' : $params['isAsc'];
        $field = $params['field']??'';
        //表单的条件 where 的条件
        if (isset($params['where']) && is_array($params['where'])) {
            foreach ($params['where'] as $key => $value) {
                if ($key && trim($value) !== '') {
                    $query = $query->where($key, $value);
                }
            }
        }

        //表单的条件 in 的条件
        if (isset($params['in']) && is_array($params['in'])) {
            foreach ($params['in'] as $key => $value) {
                if ($key && $value) {
                    $query = $query->whereIn($key, $value);
                }
            }
        }

        //表单的条件 like 的条件
        if (isset($params['like']) && is_array($params['like'])) {
            foreach ($params['like'] as $key => $value) {
                if ($key && trim($value) !== '') {
                    $query = $query->where($key, 'like', '%' . $value . '%');
                }
            }
        }

        //表单的条件 between 的条件
        if (isset($params['between']) && is_array($params['between'])) {
            foreach ($params['between'] as $key => $value) {
                if ($key && is_array($value) && count($value) > 1) {
                    $start = $value['start'] ?? '';
                    $end = $value['end'] ?? '';
                    if ($end) {
                        $end = (new \DateTime($end))->modify('+1 day')->modify('-1 second')->format('Y-m-d H:i:s');
                    }
                    if ($start) {
                        $start = (new \DateTime($start))->format('Y-m-d H:i:s');
                    }
                    if ($start || $end) {
                        if ($start && $end) {
                            $query = $query->whereBetweenTime($key, $start, $end);
                        } elseif ($start) {
                            $query = $query->whereTime($key, '>=', $start);
                        } elseif ($end) {
                            $query = $query->whereTime($key, '<=', $end);
                        }
                    }
                }
            }
        }
        //表单的条件 findinset 的条件
        if (isset($params['findinset']) && is_array($params['findinset'])) {
            foreach ($params['findinset'] as $key => $value) {
                if ($key && trim($value) !== '') {
                    $query = $query->whereFindInSet($key, $value);
                }
            }
        }

        //处理字段
        if($field){
            $query = $query->field($field);
        }

        //处理排序
        if($orderByColumn){
            $orderByColumn = 'a.id';
            $query = $query->order($orderByColumn, $isAsc);
        }

        $hasId = false;
        if ($orderBy) { // 指定排序
            foreach ($orderBy as $key => $val) {
                if($key == $orderByColumn) continue;
                if($key == 'id') $hasId = true;
                $query = $query->order($key, $val);
            }
        }
        //默认最后加一个id asc
        if (!$hasId && $orderByColumn != 'id') {
            $query = $query->order('a.id', 'desc');
        }

        return $query;
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
            $session = session();
            $data['image'] = $data['image'][0];
            $data['admin_id'] = $session['adminLoginInfo']['info']['id'];
            $data['struct_id'] = $session['adminLoginInfo']['struct'][0]['id'];
            $str="B".date('YmdH') . str_pad((string)mt_rand(1, 999999), 6, '0', STR_PAD_LEFT);
            $data['code'] = $str;
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
            $data['image'] = $data['image'][0];
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
    /**
     * 编辑渲染，方便重写
     * @param Request $request
     * @param array $info
     * @return string
     */
    protected function editRender(array $info,Request $request ):string{
        $posList = Db::table("b5net_cate")->where('status',0)->select()->toArray();
        return $this->render('', ['input' => $request->get(),'cate_id' => $info['cate_id'],'info' => $info,'posList' => $posList]);
//        return $this->render('', ['input' => $request->get(), 'info' => $info]);
    }

}