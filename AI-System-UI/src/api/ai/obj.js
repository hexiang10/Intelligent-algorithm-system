import request from '@/utils/request'

// 查询识图辨物列表
export function listObj(query) {
  return request({
    url: '/ai/obj/list',
    method: 'get',
    params: query
  })
}

// 查询识图辨物详细
export function getObj(id) {
  return request({
    url: '/ai/obj/' + id,
    method: 'get'
  })
}
// 查询识图辨物详细
export function getTestObj() {
  return request({
    url: '/ai/obj/',
    method: 'get'
  })
}

// 新增识图辨物
export function addObj(data) {
  return request({
    url: '/ai/obj',
    method: 'post',
    data: data
  })
}

// 修改识图辨物
export function updateObj(data) {
  return request({
    url: '/ai/obj',
    method: 'put',
    data: data
  })
}

// 删除识图辨物
export function delObj(id) {
  return request({
    url: '/ai/obj/' + id,
    method: 'delete'
  })
}
