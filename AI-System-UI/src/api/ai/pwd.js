import request from '@/utils/request'

// 查询密码管理列表
export function listPwd(query) {
  return request({
    url: '/ai/pwd/list',
    method: 'get',
    params: query
  })
}

// 查询密码管理详细
export function getPwd(id) {
  return request({
    url: '/ai/pwd/' + id,
    method: 'get'
  })
}

// 新增密码管理
export function addPwd(data) {
  return request({
    url: '/ai/pwd',
    method: 'post',
    data: data
  })
}

// 修改密码管理
export function updatePwd(data) {
  return request({
    url: '/ai/pwd',
    method: 'put',
    data: data
  })
}

// 删除密码管理
export function delPwd(id) {
  return request({
    url: '/ai/pwd/' + id,
    method: 'delete'
  })
}
